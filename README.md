## 这个仓库是关于iOS开发多线程方面的知识讨论意见基本的用法。主要包括GCD和Operation、KVO、通知中心、事件传递机制等几部分。demo中有完整的注释、保存在此、方便使用。

##强烈推荐配合demo中的博客一起看。都是经典。

##我会持续更新这个仓库、欢迎关注和start

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

[Dispatch Apply](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Apply)包含dispatch_semaphore、dispatch_suspend、dispatch_apply三种情况的基本用法。参考自Objective-C高级编程这本书。

//=================Dispatch Battier Demo==========

[Dispatch Battier](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Battier)可以用于实现sqlite的读写安全控制。demo里有基本用法。参考自Objective-C高级编程这本书。

//=================Dispatch Group Demo==========

[Dispatch Group](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/%E5%85%B3%E4%BA%8ENSNotificationCenter%E7%9A%84%E6%8E%A2%E8%AE%A8)可以用dispatch_group_notify、dispatch_group_wait来监听一组任务是否完成。参考自Objective-C高级编程这本书。
