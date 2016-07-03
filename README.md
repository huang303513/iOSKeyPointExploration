### 这个仓库是关于iOS开发多线程方面的知识讨论意见基本的用法。主要包括GCD和Operation、KVO、KVC、通知中心、事件传递机制等几部分。demo中有完整的注释、保存在此、方便使用。

深入理解UITableView
[自定义UITableView](http://www.jianshu.com/p/bc0a55e9b09b)</br>
[参考Demo地址](https://github.com/iThinkerYZ/YZTableView)</br>
[UITableView深入理解](http://blog.jobbole.com/70143/)</br>

[Java​Script​Core](http://nshipster.cn/javascriptcore/)</br>

[史上最详细的iOS之事件的传递和响应机制](http://www.jianshu.com/p/2e074db792ba)


[详解CALayer 和 UIView的区别和联系](http://www.jianshu.com/p/079e5cf0f014)

//=================自定义并发Operation实现对大文件的下载 Demo==========

[类似微博下拉图片放大、上拉隐藏的实现原理](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/KVC%E7%9A%84%E5%AE%9E%E7%8E%B0%E6%B5%81%E7%A8%8B%E4%BB%A5%E5%8F%8A%E6%AF%94%E7%89%B9%E7%94%A8%E6%B3%95)，自定义一个并发operation、类似与AFN的处理。参考博客地址:[参考博客地址1](http://www.jianshu.com/p/144cc0383daa)

[自定义并发Operation实现对大文件的下载](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/KVC%E7%9A%84%E5%AE%9E%E7%8E%B0%E6%B5%81%E7%A8%8B%E4%BB%A5%E5%8F%8A%E6%AF%94%E7%89%B9%E7%94%A8%E6%B3%95)，自定义一个并发operation、类似与AFN的处理。参考博客地址:[参考博客地址1](http://www.jianshu.com/p/ebb3e42049fd)

//=================KVC的实现流程以及比特用法 Demo==========

[KVC的实现流程以及比特用法(需要Xcode 7打开)](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/KVC%E7%9A%84%E5%AE%9E%E7%8E%B0%E6%B5%81%E7%A8%8B%E4%BB%A5%E5%8F%8A%E6%AF%94%E7%89%B9%E7%94%A8%E6%B3%95)，讲了KVC的实现过程以及背后的函数调用、KVC的各种比特用法以及他们实现背后的原理。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址1](http://www.jianshu.com/p/d12dba8d686c)[参考博客地址2](http://www.jianshu.com/p/6b32f6279347)[参考博客地址3](http://www.jianshu.com/p/f8cdd075439d)


//=================利用Runtime自定义控制器POP手势动画 Demo==========

[利用Runtime自定义控制器POP手势动画(需要Xcode 7打开)](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%88%A9%E7%94%A8Runtime%E8%87%AA%E5%AE%9A%E4%B9%89%E6%8E%A7%E5%88%B6%E5%99%A8POP%E6%89%8B%E5%8A%BF%E5%8A%A8%E7%94%BB)，用两种方式实现了全屏滑动返回、高度封装、其中第一种方式可以自定义pop动画。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址1](http://www.jianshu.com/p/d39f7d22db6c#fn_link_1)[参考博客地址2](https://github.com/forkingdog/FDFullscreenPopGesture)[参考博客地址3](https://github.com/huang303513/iOS-Study-Demo/tree/master/%E5%AF%BC%E8%88%AA%E6%8E%A7%E5%88%B6%E5%99%A8%E5%85%A8%E5%B1%8F%E6%BB%91%E5%8A%A8%E8%BF%94%E5%9B%9E)


//=================底层并发API之最佳实践及原理 Demo==========

[底层并发API之最佳实践及原理](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%BA%95%E5%B1%82%E5%B9%B6%E5%8F%91API%E4%B9%8B%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5%E5%8F%8A%E5%8E%9F%E7%90%86)，主要是一些理论或者最佳实践性的指导。讲了GCD的各种最佳实践原则、一写多读控制、多个异步网络请求结束通知、原子操作等各种操作。参考地址Demo中AppDelegate有。参考博客地址:[底层并发 API](http://objccn.io/issue-2-3/#watching_files)[并发编程：API 及挑战](http://objccn.io/issue-2-1/#priority_inversion)

//=================HCDWebImage Demo==========

[HCDWebImage(需要Xcode 7打开)](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/HCDWebImage)，实现了一个图片异步加载、本地缓存、队列下载等功能、通过内存缓存、磁盘缓存来实现对图片的缓存、SDWebImage的分析等。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://www.jianshu.com/p/3b2c95e1404f)[参考博客地址](http://www.jianshu.com/p/02ab2b74c451)[参考博客地址](http://mp.weixin.qq.com/s?plg_nld=1&plg_auth=1&plg_nld=1&plg_dev=1&plg_uin=1&plg_usr=1&plg_vkey=1&plg_nld=1&plg_uin=1&mid=207840007&plg_auth=1&plg_dev=1&sn=ce09553e5774f5581c696b5e28f0c7e8&plg_nld=1&idx=1&__biz=MzI1MTA1MzM2Nw%3D%3D&plg_usr=1&plg_vkey=1#rd)

//=================HCDExtension Demo==========

[HCDExtension](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/HCDExtension)，让你一步一步学会实现自己的MJExtension。非常经典。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://www.jianshu.com/p/d2ecef03f19e)

//=================OprerationQueue Demo==========

[OprerationQueue](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/OprerationQueue)涉及带InvocationOperation、BlockOperation和自定义的的并发和非并发队列的创建和使用。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://blog.leichunfeng.com/blog/2015/07/29/ios-concurrency-programming-operation-queues/)  [参考博客地址](http://www.jianshu.com/p/fe1fec3d198f)


//=================Notification与多线程以及Notification安全 Demo==========

[Notification与多线程以及Notification安全](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Notification%E4%B8%8E%E5%A4%9A%E7%BA%BF%E7%A8%8B%E4%BB%A5%E5%8F%8ANotification%E5%AE%89%E5%85%A8)涉及iOS中通知的安全和线程处理。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/14/nsnotificationyu-duo-xian-cheng/)

//=================关于NSNotificationCenter的探讨 Demo==========

[关于NSNotificationCenter的探讨](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Notification%E4%B8%8E%E5%A4%9A%E7%BA%BF%E7%A8%8B%E4%BB%A5%E5%8F%8ANotification%E5%AE%89%E5%85%A8)涉及通知的各种操作和需要注意的问题。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/20/nsnotificationcenter/)

//=================手动实现KVO、注册依赖键、集合属性监听 Demo==========

[手动实现KVO、注册依赖键、集合属性监听](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E6%89%8B%E5%8A%A8%E5%AE%9E%E7%8E%B0KVO%E3%80%81%E6%B3%A8%E5%86%8C%E4%BE%9D%E8%B5%96%E9%94%AE%E3%80%81%E9%9B%86%E5%90%88%E5%B1%9E%E6%80%A7%E7%9B%91%E5%90%AC)涉及到手动设置kvo、kvo依赖键实现、kvo数组属性改变监听等。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/04/23/nskeyvalueobserving-kvo/)



//=================iOS事件传递机制以及相应函数==========

[iOS事件传递机制以及相应函数](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/iOS%E4%BA%8B%E4%BB%B6%E4%BC%A0%E9%80%92%E6%9C%BA%E5%88%B6%E4%BB%A5%E5%8F%8A%E7%9B%B8%E5%BA%94%E5%87%BD%E6%95%B0)涉及到事件相应链的各方面以及相关函数的各种用法。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址1](http://www.superqq.com/blog/2015/04/23/iosyong-hu-dian-ji-shi-jian-chu-li/)[参考博客地址2](http://southpeak.github.io/blog/2015/03/07/uiresponder/)


//=================Dispatch Apply Demo==========

[Dispatch Apply](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Apply)包含dispatch_semaphore、dispatch_suspend、dispatch_apply三种情况的基本用法。参考自Objective-C高级编程这本书和[GCD 深入理解：第二部分](https://github.com/nixzhu/dev-blog/blob/master/2014-05-14-grand-central-dispatch-in-depth-part-2.md)

//=================Dispatch Battier Demo==========

[Dispatch Battier](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Battier)可以用于实现sqlite的读写安全控制。demo里有基本用法。参考自Objective-C高级编程这本书。

//=================Dispatch Group Demo==========

[Dispatch Group](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%85%B3%E4%BA%8ENSNotificationCenter%E7%9A%84%E6%8E%A2%E8%AE%A8)可以用dispatch_group_notify、dispatch_group_wait来监听一组任务是否完成。参考自Objective-C高级编程这本书。

##Socket编程英文文档的翻译，后面会持续更新，欢迎关注。

[套接字基础(初版)](https://github.com/huang303513/translateOfAppleDocument/blob/master/%E5%A5%97%E6%8E%A5%E5%AD%97%E5%9F%BA%E7%A1%80.md)讲了iOS套接字编程的一些基本概念，主机名和IP地址的相互转换，已经网络连接的证书认证等功能,这部分官网地址[https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/NetworkingTopics/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012546-SW1](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/NetworkingTopics/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012546-SW1)。

[URLSession 生命周期](https://github.com/huang303513/translateOfAppleDocument/blob/master/URLSession%20%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F.md)为这次翻译活动的发起人翻译。。要了解我们的活动，请关注下面这个地址[https://github.com/iOS-Developer-Documents-Chinese/iOS-Developer-Documents-Chinese](https://github.com/iOS-Developer-Documents-Chinese/iOS-Developer-Documents-Chinese)。这里后期将会有大量中文文档持续更新。
