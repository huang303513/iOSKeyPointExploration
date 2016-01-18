//
//  SecondViewController.m
//  自定义刷新控件轮子
//
//  Created by huangchengdu on 16/1/18.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import "SecondViewController.h"
#import "HCDRefreshHeaderView.h"
#import "HCDRefreshFooterView.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *refreshTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) HCDRefreshHeaderView *refreshHeaderView;
@property (nonatomic, strong) HCDRefreshFooterView *refreshFooterView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.dataSource = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 10; i++) {
        NSString *data = [NSString stringWithFormat:@"This is title %lu",i];
        [self.dataSource addObject:data];
    }
    
    CGRect tableFrame = self.view.bounds;
    tableFrame.size.height = tableFrame.size.height - 49;
    self.refreshTableView = [[UITableView alloc]initWithFrame:tableFrame];
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    self.refreshTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.refreshTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.refreshHeaderView = [[HCDRefreshHeaderView alloc] initWithScrollView:self.refreshTableView ];
    
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
    
    self.refreshFooterView = [[HCDRefreshFooterView alloc] initWithScrollView:self.refreshTableView ];
    
    [self.refreshFooterView addRefreshingBlock:^{
        // you can do some net request or other refresh operation
        // ...
        
        // here simulate do some refresh operation,and after 3s refresh complate
        NSUInteger count = weakSelf.dataSource.count;
        
        for (NSUInteger i = count; i < count + 10; i++) {
            NSString *data = [NSString stringWithFormat:@"This is title %lu",i];
            [weakSelf.dataSource addObject:data];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"控制器卸载");
}

@end
