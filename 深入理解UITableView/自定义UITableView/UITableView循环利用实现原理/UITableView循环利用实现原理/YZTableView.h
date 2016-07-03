//
//  YZTableView.h
//  UITableView循环利用实现原理
//
//  Created by 黄成都 on 15/8/26.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZTableView;
@protocol YZTableViewDataSource<NSObject>

@required

// 返回有多少行cell
- (NSInteger)tableView:(YZTableView *)tableView numberOfRowsInSection:(NSInteger)section;


// 返回每行cell长什么样子
- (UITableViewCell *)tableView:(YZTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol YZTableViewDelegate<NSObject, UIScrollViewDelegate>

// 返回每行cell有多高
- (CGFloat)tableView:(YZTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface YZTableView : UIScrollView

@property (nonatomic, weak) IBOutlet id<YZTableViewDataSource> dataSource;

@property (nonatomic, weak) IBOutlet id<YZTableViewDelegate> delegate;



// 刷新tableView
- (void)reloadData;


// 从缓存池中获取cell
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@end
