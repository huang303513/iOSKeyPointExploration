### 这个仓库是关于iOS开发多线程方面的知识讨论意见基本的用法。主要包括GCD和Operation、KVO、通知中心、事件传递机制等几部分。demo中有完整的注释、保存在此、方便使用。

##强烈推荐配合demo中的博客一起看。都是经典。

###我会持续更新这个仓库、欢迎关注和start

//=================底层并发API之最佳实践及原理 Demo==========

[底层并发API之最佳实践及原理](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%BA%95%E5%B1%82%E5%B9%B6%E5%8F%91API%E4%B9%8B%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5%E5%8F%8A%E5%8E%9F%E7%90%86)，主要是一些理论或者最佳实践性的指导。讲了GCD的各种最佳实践原则、一写多读控制、多个异步网络请求结束通知、原子操作等各种操作。参考地址Demo中AppDelegate有。参考博客地址:[底层并发 API](http://objccn.io/issue-2-3/#watching_files)[并发编程：API 及挑战](http://objccn.io/issue-2-1/#priority_inversion)

//=================Cell异步图片加载优化、缓存机制详解 Demo==========

[Cell异步图片加载优化、缓存机制详解(需要Xcode 7打开)](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Cell%E5%BC%82%E6%AD%A5%E5%9B%BE%E7%89%87%E5%8A%A0%E8%BD%BD%E4%BC%98%E5%8C%96%E3%80%81%E7%BC%93%E5%AD%98%E6%9C%BA%E5%88%B6%E8%AF%A6%E8%A7%A3)，实现了一个图片异步加载、本地缓存、队列下载等功能、通过内存缓存、磁盘缓存来实现对图片的缓存、SDWebImage的分析等。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://www.jianshu.com/p/3b2c95e1404f)[参考博客地址](http://www.jianshu.com/p/02ab2b74c451)

//=================HCDExtension Demo==========

[HCDExtension](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/HCDExtension)，让你一步一步学会实现自己的MJExtension。非常经典。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://www.jianshu.com/p/d2ecef03f19e)

//=================OprerationQueue Demo==========

[OprerationQueue](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/OprerationQueue)涉及带InvocationOperation、BlockOperation和自定义的的并发和非并发队列的创建和使用。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://blog.leichunfeng.com/blog/2015/07/29/ios-concurrency-programming-operation-queues/)


//=================Notification与多线程以及Notification安全 Demo==========

[Notification与多线程以及Notification安全](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Notification%E4%B8%8E%E5%A4%9A%E7%BA%BF%E7%A8%8B%E4%BB%A5%E5%8F%8ANotification%E5%AE%89%E5%85%A8)涉及iOS中通知的安全和线程处理。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/14/nsnotificationyu-duo-xian-cheng/)

//=================关于NSNotificationCenter的探讨 Demo==========

[关于NSNotificationCenter的探讨](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Notification%E4%B8%8E%E5%A4%9A%E7%BA%BF%E7%A8%8B%E4%BB%A5%E5%8F%8ANotification%E5%AE%89%E5%85%A8)涉及通知的各种操作和需要注意的问题。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/20/nsnotificationcenter/)

//=================手动实现KVO、注册依赖键、集合属性监听 Demo==========

[手动实现KVO、注册依赖键、集合属性监听](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E6%89%8B%E5%8A%A8%E5%AE%9E%E7%8E%B0KVO%E3%80%81%E6%B3%A8%E5%86%8C%E4%BE%9D%E8%B5%96%E9%94%AE%E3%80%81%E9%9B%86%E5%90%88%E5%B1%9E%E6%80%A7%E7%9B%91%E5%90%AC)涉及到手动设置kvo、kvo依赖键实现、kvo数组属性改变监听等。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/04/23/nskeyvalueobserving-kvo/)

//=================关于NSNotificationCenter的探讨==========

[关于NSNotificationCenter的探讨](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%85%B3%E4%BA%8ENSNotificationCenter%E7%9A%84%E6%8E%A2%E8%AE%A8)涉及到通知中心的各种原理和注意事项、用法。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/20/nsnotificationcenter/)


//=================iOS事件传递机制以及相应函数==========

[iOS事件传递机制以及相应函数](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/iOS%E4%BA%8B%E4%BB%B6%E4%BC%A0%E9%80%92%E6%9C%BA%E5%88%B6%E4%BB%A5%E5%8F%8A%E7%9B%B8%E5%BA%94%E5%87%BD%E6%95%B0)涉及到事件相应链的各方面以及相关函数的各种用法。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址1](http://www.superqq.com/blog/2015/04/23/iosyong-hu-dian-ji-shi-jian-chu-li/)[参考博客地址2](http://southpeak.github.io/blog/2015/03/07/uiresponder/)


//=================Dispatch Apply Demo==========

[Dispatch Apply](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Apply)包含dispatch_semaphore、dispatch_suspend、dispatch_apply三种情况的基本用法。参考自Objective-C高级编程这本书和[GCD 深入理解：第二部分](https://github.com/nixzhu/dev-blog/blob/master/2014-05-14-grand-central-dispatch-in-depth-part-2.md)

//=================Dispatch Battier Demo==========

[Dispatch Battier](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Battier)可以用于实现sqlite的读写安全控制。demo里有基本用法。参考自Objective-C高级编程这本书。

//=================Dispatch Group Demo==========

[Dispatch Group](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%85%B3%E4%BA%8ENSNotificationCenter%E7%9A%84%E6%8E%A2%E8%AE%A8)可以用dispatch_group_notify、dispatch_group_wait来监听一组任务是否完成。参考自Objective-C高级编程这本书。
