//
//  HCDHttpDownOperation.m
//  自定义并发Operation实现对大文件的下载
//
//  Created by 黄成都 on 15/12/5.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDHttpDownOperation.h"

#define DELEGATE_HAS_METHOD(delegate, method) delegate && [delegate respondsToSelector:@selector(method)]

typedef NS_ENUM(NSInteger, RJRequestState) {
    RJRequestStateReady     = 0,
    RJRequestStateExecuting = 1,
    RJRequestStateFinished  = 2,
};

static const NSTimeInterval kRequestTimeout = 20.0f;

@interface HCDHttpDownOperation ()<NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *fileData;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURLConnection *connection;
//总长度
@property (nonatomic, assign) float expectedLength;
//接收到得长度
@property (nonatomic, assign) float receivedLength;
//当前状态
@property (nonatomic, assign) RJRequestState state;
//下载操作所在的线程的runloop
@property (nonatomic, assign) CFRunLoopRef operationRunLoop;
//代理
@property (nonatomic, weak) id <HCDHttpDownLoadDelegate> delegate;
//下载完成回调
@property (nonatomic, copy) void (^completion)(id response, NSError *error);
//下载进度回调
@property (nonatomic, copy) void (^progress)(float percent);
@end

@implementation HCDHttpDownOperation
@synthesize state = _state;
#pragma mark 初始化方法
-(id)initWithRequestURL:(NSURL *)url delegate:(id<HCDHttpDownLoadDelegate>)delegate{
    return [self initWithRequestURL:url delegate:delegate progress:nil completion:nil];
}
- (id)initWithRequestURL:(NSURL *)URL
                progress:(void (^)(float percent))progress
              completion:(void (^)(id response, NSError *error))completion
{
    return [self initWithRequestURL:URL delegate:nil progress:progress completion:completion];
}

#pragma mark 主初始化方法
- (id)initWithRequestURL:(NSURL *)URL
                delegate:(id<HCDHttpDownLoadDelegate>)delegate
                progress:(void (^)(float percent))progress
              completion:(void (^)(id response, NSError *error))completion
{
    if (self = [super init]) {
        self.delegate   = delegate;
        self.progress   = progress;
        self.completion = completion;
        
        self.request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData
            timeoutInterval:kRequestTimeout];
    }
    return self;
}
- (void)dealloc
{
    [self.connection cancel];
}

#pragma mark 必须重写start
-(void)start{
    if (self.isCancelled) {
        [self finish]; return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    self.state = RJRequestStateExecuting;
    [self didChangeValueForKey:@"isExecuting"];
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request
        delegate:self startImmediately:NO];
    //得到operation所在的队列
    NSOperationQueue *currentQueue = [NSOperationQueue currentQueue];
    //是否是主队列
    BOOL backgroundQueue           = (currentQueue != nil && currentQueue != [NSOperationQueue mainQueue]);
    //得带当前operaion所在线程的runloop
    NSRunLoop *targetRunLoop       = (backgroundQueue)?[NSRunLoop currentRunLoop]:[NSRunLoop mainRunLoop];
    //把链接加入runloop中，这样就避免在子线程中操作的时候不能接收回调。这个runloop会一直运行到我们手动停止他为止。
    [self.connection scheduleInRunLoop:targetRunLoop forMode:NSRunLoopCommonModes];
    [self.connection start];
    
    //如果是子线程中处理，我们需要手动启动runloop
    if (backgroundQueue) {
        self.operationRunLoop = CFRunLoopGetCurrent(); CFRunLoopRun();
    }

}
- (void)cancel
{
    if (![self isExecuting]) return;
    
    [super cancel]; [self finish];
}
#pragma mark 并发
- (BOOL)isConcurrent
{
    return YES;
}
#pragma mark 通过状态机来得到当前操作的状态
- (BOOL)isFinished
{
    return self.state == RJRequestStateFinished;
}
#pragma mark 通过状态机来得到当前操作的状态
- (BOOL)isExecuting
{
    return self.state == RJRequestStateExecuting;
}
#pragma mark - Request Status
- (void)finish
{
    [self.connection cancel]; self.connection = nil;
    //手动出发kvo。
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    self.state = RJRequestStateFinished;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}
//get方法同步
- (RJRequestState)state
{
    @synchronized(self) {
        return _state;
    }
}
//setter方法重写来设置操作的状态
- (void)setState:(RJRequestState)newState
{
    @synchronized(self) {
        [self willChangeValueForKey:@"state"];
        _state = newState;
        [self didChangeValueForKey:@"state"];
    }
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //数据总长度
    self.expectedLength = response.expectedContentLength;
    self.receivedLength = 0;
    self.fileData       = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.fileData appendData:data]; self.receivedLength += data.length;
    
    float percent = self.receivedLength / self.expectedLength;
    
    if (self.progress) self.progress(percent);
    
    if (DELEGATE_HAS_METHOD(self.delegate, HCDHttpDownLoader:downLoadProgress:)) {
        [self.delegate HCDHttpDownLoader:self downLoadProgress:percent];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self downloadFinishedWithResponse:self.fileData error:nil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self downloadFinishedWithResponse:nil error:error];
}

#pragma mark - Download Finished
- (void)downloadFinishedWithResponse:(id)response error:(NSError *)error
{
    //手动停止nsurlconnection所在runloop。
    if (self.operationRunLoop) CFRunLoopStop(self.operationRunLoop);
    
    if (self.isCancelled) return;
    
    if (self.completion) self.completion(self.fileData, error);
    
    if (response && DELEGATE_HAS_METHOD(self.delegate, HCDHttpDownLoader:didFinishWithData:))
    {
        [self.delegate HCDHttpDownLoader:self didFinishWithData:response];
    }
    else if (!response && DELEGATE_HAS_METHOD(self.delegate, HCDHttpDownLoader:didFailWithError:))
    {
        [self.delegate HCDHttpDownLoader:self didFailWithError:error];
    }
    
    [self finish];
}

@end
