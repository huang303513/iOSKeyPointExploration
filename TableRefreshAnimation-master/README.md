# TableRefreshAnimation

## Introduction
TableView pull down or pull up refresh animation

## How to use
add header view,you can set if there is a navigation bar
```obejct-c
    self.refreshHeaderView = [[TableHeaderRefreshView alloc] initWithScrollView:self.refreshTableView hasNavigationBar:YES];

    [self.refreshHeaderView doRefresh];

    __weak __typeof(&*self)weakSelf = self;
    [self.refreshHeaderView addRefreshingBlock:^{
        // you can do some net request or other refresh operation
        // ...

        // here simulate do some refresh operation,and after 3s refresh complate
        double delayTime = 3.0;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [weakSelf.refreshHeaderView stopRefresh];
        });
    }];
```

add footer view,you can set if there is a navigation bar
```object-c
    self.refreshFooterView = [[TableFooterRefreshView alloc] initWithScrollView:self.refreshTableView hasNavigationBar:YES];

    [self.refreshFooterView addRefreshingBlock:^{
        // you can do some net request or other refresh operation
        // ...

        // here simulate do some refresh operation,and after 3s refresh complate
        double delayTime = 3.0;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [weakSelf.refreshFooterView stopRefresh];
        });
    }];
```

## Gif
![](https://github.com/Yuzeyang/TableRefreshAnimation/raw/master/TableRefreshAnimation1.gif)
![](https://github.com/Yuzeyang/TableRefreshAnimation/raw/master/TableRefreshAnimation2.gif)