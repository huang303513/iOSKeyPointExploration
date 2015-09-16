# 这个仓库是关于iOS开发多线程方面的知识讨论意见基本的用法。主要包括GCD和Operation两部分。demo中有完整的注释、保存在此、方便使用。

#我会持续更新这个仓库、欢迎关注和start

//=================Dispatch Apply Demo==========

[Dispatch Apply](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Apply)包含dispatch_semaphore、dispatch_suspend、dispatch_apply三种情况的基本用法。参考自Objective-C高级编程这本书。

//=================Dispatch Battier Demo==========

[Dispatch Battier](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Battier)可以用于实现sqlite的读写安全控制。demo里有基本用法。参考自Objective-C高级编程这本书。

//=================Dispatch Group Demo==========

[Dispatch Group](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Dispatch%20Group)可以用dispatch_group_notify、dispatch_group_wait来监听一组任务是否完成。参考自Objective-C高级编程这本书。

//=================OprerationQueue Demo==========

[OprerationQueue](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/OprerationQueue)涉及带InvocationOperation、BlockOperation和自定义的的并发和非并发队列的创建和使用。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://blog.leichunfeng.com/blog/2015/07/29/ios-concurrency-programming-operation-queues/)


//=================Notification与多线程以及Notification安全 Demo==========

[Notification与多线程以及Notification安全](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Notification%E4%B8%8E%E5%A4%9A%E7%BA%BF%E7%A8%8B%E4%BB%A5%E5%8F%8ANotification%E5%AE%89%E5%85%A8)涉及iOS中通知的安全和线程处理。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/14/nsnotificationyu-duo-xian-cheng/)

[关于NSNotificationCenter的探讨](https://github.com/huang303513/GCD-OperationQueue-Exploration/tree/master/Notification%E4%B8%8E%E5%A4%9A%E7%BA%BF%E7%A8%8B%E4%BB%A5%E5%8F%8ANotification%E5%AE%89%E5%85%A8)涉及通知的各种操作和需要注意的问题。参考地址Demo中AppDelegate有。参考博客地址:[参考博客地址](http://southpeak.github.io/blog/2015/03/20/nsnotificationcenter/)






