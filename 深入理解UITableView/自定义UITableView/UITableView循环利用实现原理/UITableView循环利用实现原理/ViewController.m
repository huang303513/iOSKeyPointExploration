//
//  ViewController.m
//  UITableView循环利用实现原理
//
//  Created by yz on 15/8/8.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "ViewController.h"
#import "YZTableView.h"
@interface ViewController ()<YZTableViewDataSource, YZTableViewDelegate>

@property (strong, nonatomic) IBOutlet YZTableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (NSInteger)tableView:(YZTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
// 返回每一行cell的样子
- (UITableViewCell *)tableView:(YZTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    cell.imageView.image = [UIImage imageNamed:@"公司Logo"];
    
    
    
    return cell;
}

// 返回每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}





@end
