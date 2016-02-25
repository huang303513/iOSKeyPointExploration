//
//  HeaderImageViewController.m
//  BaseTableView
//
//  Created by ErosLii on 16/2/18.
//  Copyright © 2016年 Draven. All rights reserved.
//

#import "HeaderImageViewController.h"
#import "ViewController.h"


#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeigh            [UIScreen mainScreen].bounds.size.heigh

#define kReuseIdentifi          @"Cell"
#define kImageHeigh             200 //图片的高度
#define kImageContainerHeigh    150 //图片容器的高度

@interface HeaderImageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UIView *imageContainerView;
@property (strong, nonatomic) UIImageView *topImageView;

@end

@implementation HeaderImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.imageContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    self.topImageView = [[UIImageView alloc] initWithFrame:self.imageContainerView.bounds];
    self.topImageView.image = [UIImage imageNamed:@"account_bg"];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topImageView.clipsToBounds = YES;
    [self.imageContainerView addSubview:self.topImageView];
    [self.tableView insertSubview:self.imageContainerView atIndex:0];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置内容偏移量,设置完成之后,不要忘了,这时候tableView的初始offset就不是0了,而是-kImageContainerHeigh
    self.tableView.contentInset = UIEdgeInsetsMake(kImageContainerHeigh, 0, 0, 0);
    //将它放置在tableView下面,保证上滑的时候盖住
    [self.tableView insertSubview:self.imageContainerView atIndex:0];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifi];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifi forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.textLabel.text = @"模仿新浪微博个人详情页";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",self.tableView.contentOffset.y);
    CGFloat offset_Y = self.tableView.contentOffset.y;
    CGFloat delta = kImageContainerHeigh + offset_Y;    //相对偏移量
    
    //向上拖动(offset变为正值之前)
    if (-offset_Y < kImageContainerHeigh && offset_Y < 0) {
        CGRect frame = self.topImageView.frame;
        frame.origin.y = offset_Y;
        frame.size.height = -offset_Y;
        self.topImageView.frame = frame;
        
    } else if (offset_Y < 0) {
        //向下拖动
        CGRect frame = self.topImageView.frame;
        frame.size.width = kScreenWidth - (delta)/2;
        frame.size.height = -offset_Y;
        frame.origin.y = offset_Y;
        frame.origin.x = delta / 4;
        self.topImageView.frame = frame;
    }
    
}




@end
