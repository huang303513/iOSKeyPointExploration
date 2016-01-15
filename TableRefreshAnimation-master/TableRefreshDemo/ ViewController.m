//
//  ViewController.m
//  TableRefreshDemo
//
//  Created by 宫城 on 15/12/31.
//  Copyright © 2015年 宫城. All rights reserved.
//

#import "ViewController.h"
#import "TableHeaderRefreshView.h"
#import "TableFooterRefreshView.h"

#define kMaxDataSourceCount 20


#warning 参考地址：http://www.jianshu.com/p/8ff5383481d3


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *refreshTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) TableHeaderRefreshView *refreshHeaderView;
@property (nonatomic, strong) TableFooterRefreshView *refreshFooterView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 10; i++) {
        NSString *data = [NSString stringWithFormat:@"This is title %lu",i];
        [self.dataSource addObject:data];
    }
    
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    self.refreshTableView.tableFooterView = [UIView new];
    [self.refreshTableView layoutIfNeeded];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
    
    self.refreshFooterView = [[TableFooterRefreshView alloc] initWithScrollView:self.refreshTableView hasNavigationBar:YES];
    
    [self.refreshFooterView addRefreshingBlock:^{
        // you can do some net request or other refresh operation
        // ...
        
        // here simulate do some refresh operation,and after 3s refresh complate
        NSUInteger count = weakSelf.dataSource.count;
        if (count <= kMaxDataSourceCount) {
            for (NSUInteger i = count; i < count + 10; i++) {
                NSString *data = [NSString stringWithFormat:@"This is title %lu",i];
                [weakSelf.dataSource addObject:data];
            }
        }
        
        double delayTime = 3.0;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [weakSelf.refreshTableView reloadData];
            [weakSelf.refreshFooterView stopRefresh];
       });
    }];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"icon.jpg"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

@end
