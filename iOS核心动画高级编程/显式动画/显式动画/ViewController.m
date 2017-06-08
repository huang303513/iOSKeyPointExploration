//
//  ViewController.m
//  显式动画
//
//  Created by maiyun on 15/6/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "AnimationType.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataSourceList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview = [[UITableView alloc]init];
    self.tableview.frame = self.view.frame;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.view addSubview:self.tableview];
    
    self.dataSourceList = [NSMutableArray array];
    
    AnimationType *animationType;
    animationType = [[AnimationType alloc]initWithTitle:@"通过CATransaction做动画" detailTitle:@"通过CATransaction做动画FirstVC第八章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"通过CABasicAnimation实现时钟效果" detailTitle:@"通过CABasicAnimation实现时钟效果secondVC第八章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"通过CABaseAnimation实现图层的旋转" detailTitle:@"通过CABaseAnimation实现图层的旋转thirdVC第八章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"通过CAAnimationGroup实现动画组" detailTitle:@"通过CAAnimationGroup实现动画组fourVC第八章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"通过过渡动画和uitabbarcontroller的代理来切换动画" detailTitle:@"通过过渡动画和uitabbarcontroller的代理来切换动画fiveVC第八章"];
    [self.dataSourceList addObject:animationType];
    
    
    animationType = [[AnimationType alloc]initWithTitle:@"使用UIKit提供的方法来做过渡动画" detailTitle:@"使用UIKit提供的方法来做过渡动画sixVC第八章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"使用renderInContext自定义过渡动画" detailTitle:@"使用renderInContext自定义过渡动画sevenVC第八章"];
    [self.dataSourceList addObject:animationType];

    
    [self.tableview reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaaaa"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"aaaaa"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AnimationType *currentType = self.dataSourceList[indexPath.row];
    cell.textLabel.text = currentType.title;
    cell.detailTextLabel.text = currentType.detailTitle;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FirstViewController *firstVC = [[FirstViewController alloc]init];
        [self.navigationController pushViewController:firstVC animated:YES];
    }else if(indexPath.row == 1){
        SecondViewController *secondVC = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:secondVC animated:YES];
    }else if(indexPath.row == 2){
        ThirdViewController *thirdVC = [[ThirdViewController alloc]init];
        [self.navigationController pushViewController:thirdVC animated:YES];
    }else if(indexPath.row == 3){
        FourViewController *fourVC = [[FourViewController alloc]init];
        [self.navigationController pushViewController:fourVC animated:YES];
    }else if(indexPath.row == 4){
        FiveViewController *fiveVC  = [[FiveViewController alloc]init];
        [self.navigationController pushViewController:fiveVC animated:YES];
    }else if(indexPath.row == 5){
        SixViewController *sixVC  = [[SixViewController alloc]init];
        [self.navigationController pushViewController:sixVC animated:YES];
    }else if(indexPath.row == 6){
        SevenViewController *sevenVC  = [[SevenViewController alloc]init];
        [self.navigationController pushViewController:sevenVC animated:YES];
    }

    
}




@end
