//
//  ViewController.m
//  TableViewHeaderImageEffect
//
//  Created by ErosLii on 16/2/19.
//  Copyright © 2016年 weelh. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"

#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeigh            [UIScreen mainScreen].bounds.size.heigh

#define kReuseIdentifi          @"Cell"
#define kImageContainerHeigh    150
#define kMiddleBarHeigh         40
#define kTotalHeigh             kImageContainerHeigh+kMiddleBarHeigh

@interface ViewController ()<UITabBarDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weiboLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhuyeLeft;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.weiboLeft.constant = (kScreenWidth-(200+120))/2;
    
    self.mainTableView.contentInset = UIEdgeInsetsMake(kTotalHeigh, 0, 0, 0);
    //这句话要加上,因为我在xib拖上去的HeaderView是和TableView并列关系,所以这里把它加到tableView并且处在下层,否则会出现遮挡的bug,可以注掉这行代码试一下
    [self.mainTableView insertSubview:self.headerView atIndex:0];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifi];
    
    // 给导航条的背景图片传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 隐藏底部阴影条，传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f",self.mainTableView.contentOffset.y);
    CGFloat offset_Y = self.mainTableView.contentOffset.y;
    CGFloat delta = offset_Y + kTotalHeigh;
    
    //向上滑动
    CGFloat heigh = kImageContainerHeigh-delta;
    //当减小到64,到导航栏的位置,就不再减少了
    if (heigh<64) {
        heigh = 64;
    }
    self.headerHeigh.constant = heigh;
    
    CGFloat alpha = delta/(kImageContainerHeigh-64);
    if (alpha>=1) {
        alpha = 0.99;
    }
    // 设置导航条的背景图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
}

@end
