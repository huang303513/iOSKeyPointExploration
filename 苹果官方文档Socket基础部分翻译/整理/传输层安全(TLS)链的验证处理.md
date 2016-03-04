#传输层安全(TLS)链的验证处理</br>
[原文地址](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/NetworkingTopics/Articles/ResolvingDNSHostnames.html#//apple_ref/doc/uid/TP40012543-SW1)
翻译人:一帆  日期:2015.9.10

这部分将讨论如何验证传输层安全(Transport Layer Security)并且正确地的处理传输层安全。

>重要：这部分假设你已经读了[Cryptographic Services](https://developer.apple.com/library/ios/documentation/Security/Conceptual/Security_Overview/CryptographicServices/CryptographicServices.html#//apple_ref/doc/uid/TP30000976-CH3)部分或者对认证、签名和信任链(chains of trust).
>大部分软件不用确保链确认(chain validation)。然而，在开发中做这个处理很正常。通过这里所讲的技术来确保链确认正确地执行。你的用户没有保护措施如果你非故意的发布一个没有调试的软件版本。

当一个TLS证书被证实了，操作系统会证实信任链。如果信任链只包含有效的证书并且以一个可信证书结尾，这个证书被认为是有效地。如果不是这样，证书就是无效的。如果你从一个一般的证书颁发结构请求一个证书，这个证书只被认为是“能工作的”。

然而，如果你通过一些可靠证书为你的用户提供服务，为多个局域网提供服务通过一个证书并且不被这些局域网，用一个自签名证书，通过IP地址连接(这样的话网络堆栈不会知道主机的名字),等等---你需要做一些额外的操作来让操作系统接受证书。

在高层网络层上，TLS链可以通过一个认证对象来执行(SecTrustRef)。这个对象包含一些标志来确认那种类型的认证被执行了。你不能手动修改这些标志，但是你可以意识到他们的存在。另外，认证对象包含一个策略(SecPolicyRef)允许你提供主机名，这个主机名会在执行TLS证书的事后被使用。最后，认证对象包含一些安全的证书，这些证书是你的应用可以转换的。

这部分被分为几个小的部分。第一部分[Manipulating Trust Objects]()包括一般的操作认证对象从而改变认证行为。剩下的[Trust Objects and NSURLConnection]()和[Trust Objects and NSStream]()展示如何集成这些改变通过不同的方式。

###操作认证对象
操作认证对象的细节很大一部分取决于你具体尝试做什么。通常做的两个操作是主机名(它必须证书一般的名字或者适配一些列名称扩展)和anchor(它通常决定一系列可信任证书认证)。

如果要添加一个证书到信任的证书锚，你必须复制现有的证书锚到一个数组里面，创建这个数据的可变副本，添加新证书到可变数组副本里面，然后告诉认证对象用这个新的数据来做认证处理。下面是一个实现功能的简单地函数：

Listing 1  添加一个锚到`SecTrustRef`对象中

```Objective-C
SecTrustRef addAnchorToTrust(SecTrustRef trust, SecCertificateRef trustedCert)

{

#ifdef PRE_10_6_COMPAT

        CFArrayRef oldAnchorArray = NULL;

 

        /* In OS X prior to 10.6, copy the built-in

           anchors into a new array. */

        if (SecTrustCopyAnchorCertificates(&oldAnchorArray) != errSecSuccess) {

                /* Something went wrong. */

                return NULL;

        }

 

        CFMutableArrayRef newAnchorArray = CFArrayCreateMutableCopy(

                kCFAllocatorDefault, 0, oldAnchorArray);

        CFRelease(oldAnchorArray);

#else

        /* In iOS and OS X v10.6 and later, just create an empty

           array. */

        CFMutableArrayRef newAnchorArray = CFArrayCreateMutable (

                kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);

#endif

 

        CFArrayAppendValue(newAnchorArray, trustedCert);

 

        SecTrustSetAnchorCertificates(trust, newAnchorArray);

 

#ifndef PRE_10_6_COMPAT

        /* In iOS or OS X v10.6 and later, reenable the

           built-in anchors after adding your own.

         */

        SecTrustSetAnchorCertificatesOnly(trust, false);

#endif

 

        return trust;
```

>注意：要为trustedCert对象构建一个SecCertificateRef对象，首先加载一个DER编码的证书到CFData对象中，然后调用SecCertificateCreateWithData。
>更多操作，包括通过其他编码方式加载证书，在OS X 10.7以后你也可以使用`SecItemImport`。

当忽略主机名(允许一个站点证书为另一个站点的证书工作，或者允许允许一个证书工作当你通过IP地址连接到一个主机)的时候，你必须代替认证对象，这个认证对象用于决定如何终止认证。要做这些操作，首先为指定的主机名创建一个新的TLS认证对象。然后创建一个包括那个认证对象的数组。最后让认证对象用这个数组做以后的认证操作。Listing 2 的函数展示了这个过程：

Listing 2 为一个SecTrustRef对象改变远程主机名

```Objective-C
SecTrustRef changeHostForTrust(SecTrustRef trust)

{

        CFMutableArrayRef newTrustPolicies = CFArrayCreateMutable(

                kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);

 

        SecPolicyRef sslPolicy = SecPolicyCreateSSL(true, CFSTR("www.example.com"));

 

        CFArrayAppendValue(newTrustPolicies, sslPolicy);

 

#ifdef MAC_BACKWARDS_COMPATIBILITY

        /* This technique works in OS X (v10.5 and later) */

 

        SecTrustSetPolicies(trust, newTrustPolicies);

        CFRelease(oldTrustPolicies);

 

        return trust;

#else

        /* This technique works in iOS 2 and later, or

           OS X v10.7 and later */

 

        CFMutableArrayRef certificates = CFArrayCreateMutable(

                kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);

 

        /* Copy the certificates from the original trust object */

        CFIndex count = SecTrustGetCertificateCount(trust);

        CFIndex i=0;

        for (i = 0; i < count; i++) {

                SecCertificateRef item = SecTrustGetCertificateAtIndex(trust, i);

                CFArrayAppendValue(certificates, item);

        }

 

        /* Create a new trust object */

        SecTrustRef newtrust = NULL;

        if (SecTrustCreateWithCertificates(certificates, newTrustPolicies, &newtrust) != errSecSuccess) {

                /* Probably a good spot to log something. */

 

                return NULL;

        }

 

        return newtrust;

#endif

}

 

```

###认证对象和NSURLConnection

如果要重载NSURLConnection的认证链行为，你必须重载下面两个方法：

* connection:canAuthenticateAgainstProtectionSpace:
* 这个方法让NSURLConnection知道如何处理特定类型的认证。当你的应用决定是否信任一个服务器证书的事后，这也是一种认证方式---你的应用认证了服务器。

*connection:didReceiveAuthenticationChallenge:
* 在这个方法中，你的应用需要转换信任策略，键。服务器或者客户端提供的主机名以便让信任策略被成功的执行。

listing3将会演示两个方法的使用。

listing 3 重载被NSURLConnection对象使用的信任对象

```Objective-C
// If you are building for OS X 10.7 and later or iOS 5 and later,

// leave out the first method and use the second method as the

// connection:willSendRequestForAuthenticationChallenge: method.

// For earlier operating systems, include the first method, and

// use the second method as the connection:didReceiveAuthenticationChallenge:

// method.

 

#ifndef NEW_STYLE

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {

    #pragma unused(connection)

 

    NSString *method = [protectionSpace authenticationMethod];

    if (method == NSURLAuthenticationMethodServerTrust) {

           return YES;

    }

    return NO;

}

 

-(void)connection:(NSURLConnection *)connection

        didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

#else

-(void)connection:(NSURLConnection *)connection

        willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge

#endif

{

    NSURLProtectionSpace *protectionSpace = [challenge protectionSpace];

    if ([protectionSpace authenticationMethod] == NSURLAuthenticationMethodServerTrust) {

    SecTrustRef trust = [protectionSpace serverTrust];

 

    /***** Make specific changes to the trust policy here. *****/

 

    /* Re-evaluate the trust policy. */

    SecTrustResultType secresult = kSecTrustResultInvalid;

    if (SecTrustEvaluate(trust, &secresult) != errSecSuccess) {

        /* Trust evaluation failed. */

 

        [connection cancel];

 

        // Perform other cleanup here, as needed.

        return;

    }

 

    switch (secresult) {

        case kSecTrustResultUnspecified: // The OS trusts this certificate implicitly.

        case kSecTrustResultProceed: // The user explicitly told the OS to trust it.

            {

            NSURLCredential *credential =

                [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

            [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];

            return;

            }

        default:

            /* It's somebody else's key. Fall through. */

    }

    /* The server sent a key other than the trusted key. */

    [connection cancel];

 

    // Perform other cleanup here, as needed.

    }

}


```
###信任对象和NSStream
你重载NSStream对象的方式取决于你要做的事情。

如果你需要指定一个不同的TLS主机名，你可以通过下面的几行代码细致的执行在你打开一个数据流之前。

listing 4 通过NSStream重载TLS主机名

```Objective-C
      NSDictionary *sslSettings =

                [NSDictionary dictionaryWithObjectsAndKeys:

                        @"www.gatwood.net",

                        (__bridge id)kCFStreamSSLPeerName, nil];

        if (![myInputStream setProperty: sslSettings

            forKey: (__bridge NSString *)kCFStreamPropertySSLSettings]) {

                // Handle the error here.

        }```

上面的代码改变数据流的主机名，从而当数据流接下来创建信任对象的时候，它可以提供新的主机名。

如果你需要提供准确的`trusted anchors`，处理过程就更复杂了。当一个数据流创建信任对象的时候，数据流会评估信任对象。如果信任对象评估失败，数据流会在代码正确转换信任对象之前关闭。所以，要重载信任评估过程，你需要执行：

* 禁止TLS链的确认。因为数据流永远不会执行TLS链，执行永远不会失败，所以数据流永远不会被关闭。
* 在数据流的代理方法里面手动执行TLS链的确认(在转换信任对象以后)。

当数据流代理的事件处理句柄被调用来表明某个空间可以被套接字使用的时候，操作系统已经构建了一个TLS通道，从其他链接的结尾取得一个认证链，并且创建一个信任对象来执行它。这个时候，你有一个开放的TLS数据流，但是你不知道是否你能信任远程的主机。通过禁止TLS链确认，认证另一端的远程主机是否被信任变成`你的职责`。换句话说，意味着：

* 通过创建一个非TLS策略来允许主机核查或者把主机名指定为一个NULL指针。如果你打算链接到一个主机通过主机名并且这个主机名是在信任证书列表里面的一个名字。只有在你收到的证书来自某个`你能控制的地方`时，你才会允许这个操作。
* 不要轻率的信任自签名证书作为anchors(kSecTrustOptionImplicitAnchors)。添加你自己的CA证书到信任列表。
* 不要任意的禁止其他证书选项，比如失效证书和根证书的核实。有一些特定的操作也许可以起作用(比如把文档标记回到2001如果这个文档在2001是有效的)，但是对于网络通讯过程来讲，默认选项一般不用管。

通过上面提到的规则，Listing 5 展示了如何用NSSream对象来使用自定义TLS anchor。这个列表页也用到列表1的函数`addAnchorToTrust `。

Listing 5 通过NSStream使用自定义TLS anchor。

```Objective-C
/* Code executed after creating the socket: */

 

        [inStream setProperty:NSStreamSocketSecurityLevelNegotiatedSSL

            forKey:NSStreamSocketSecurityLevelKey];

 

    NSDictionary *sslSettings =

        [NSDictionary dictionaryWithObjectsAndKeys:

        (id)kCFBooleanFalse, (id)kCFStreamSSLValidatesCertificateChain,

        nil];

 

    [inStream setProperty: sslSettings forKey: (__bridge NSString *)kCFStreamPropertySSLSettings];
...

/* Methods in your stream delegate class */

 

NSString *kAnchorAlreadyAdded = @"AnchorAlreadyAdded";

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent

{

    if (streamEvent == NSStreamEventHasBytesAvailable || streamEvent == NSStreamEventHasSpaceAvailable) {

        /* Check it. */

 

        NSArray *certs = [theStream propertyForKey: (__bridge NSString *)kCFStreamPropertySSLPeerCertificates];

        SecTrustRef trust = (SecTrustRef)[theStream propertyForKey: (__bridge NSString *)kCFStreamPropertySSLPeerTrust];

 

        /* Because you don't want the array of certificates to keep

           growing, you should add the anchor to the trust list only

           upon the initial receipt of data (rather than every time).

         */

        NSNumber *alreadyAdded = [theStream propertyForKey: kAnchorAlreadyAdded];

        if (!alreadyAdded || ![alreadyAdded boolValue]) {

            trust = addAnchorToTrust(trust, self.trustedCert); // defined earlier.

            [theStream setProperty: [NSNumber numberWithBool: YES] forKey: kAnchorAlreadyAdded];

        }

        SecTrustResultType res = kSecTrustResultInvalid;

 

        if (SecTrustEvaluate(trust, &res)) {

            /* The trust evaluation failed for some reason.

               This probably means your certificate was broken

               in some way or your code is otherwise wrong. */

 

            /* Tear down the input stream. */

            [theStream removeFromRunLoop: ... forMode: ...];

            [theStream setDelegate: nil];

            [theStream close];

 

            /* Tear down the output stream. */

            ...

 

            return;

 

        }

 

        if (res != kSecTrustResultProceed && res != kSecTrustResultUnspecified) {

            /* The host is not trusted. */

            /* Tear down the input stream. */

            [theStream removeFromRunLoop: ... forMode: ...];

            [theStream setDelegate: nil];

            [theStream close];

 

            /* Tear down the output stream. */

            ...

 

        } else {

            // Host is trusted.  Handle the data callback normally.

 

        }

    }

}```
<br />
