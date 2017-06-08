//
//  ViewController.m
//  图层旋转摆放扭曲等
//
//  Created by maiyun on 15/6/15.
//  Copyright (c) 2015年 黄成都. All rights reserved.
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
#import "EightViewController.h"
#import "NinethViewController.h"
#import "TenthViewController.h"
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
    animationType = [[AnimationType alloc]initWithTitle:@"通过CAShapeLayer画出一个火柴人" detailTitle:@"通过CAShapeLayer画出一个火柴人FirstVC第六章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"CATextLayer实现多行文字显示" detailTitle:@"CATextLayer实现多行文字显示secondVC第六章"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"CATextLayer实现富文本" detailTitle:@"CATextLayer实现富文本thirdVC第六章"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"用CATextLayer实现UILable子类" detailTitle:@"用CATextLayer实现UILable子类fourVC第六章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"用CAGradientLayer事先渐变视图" detailTitle:@"用CAGradientLayer事先渐变视图fiveVC第六章"];
    [self.dataSourceList addObject:animationType];
    
    animationType = [[AnimationType alloc]initWithTitle:@"用CAReplicatorLayer视图的倒影" detailTitle:@"用CAReplicatorLayer视图的倒影sixVC第六章"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"用CAScrollLayer实现模拟的scrollView" detailTitle:@"用CAScrollLayer实现模拟的scrollView第sevenVC第六章"];
    [self.dataSourceList addObject:animationType];
    
    
    animationType = [[AnimationType alloc]initWithTitle:@"用AVPlayerLayer实现播放视频" detailTitle:@"用AVPlayerLayer实现播放视频eightVC第六章"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"十个正方形依次旋转36度" detailTitle:@"十个正方形依次旋转36度"];
    [self.dataSourceList addObject:animationType];

    animationType = [[AnimationType alloc]initWithTitle:@"实现子弹爆炸的动画" detailTitle:@"实现子弹爆炸的动画"];
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
    if (indexPath.row == 0) {//旋转45度
        FirstViewController *firstVC = [[FirstViewController alloc]init];
        firstVC.type = 1;
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
        FiveViewController *fiveVC = [[FiveViewController alloc]init];
        [self.navigationController pushViewController:fiveVC animated:YES];
    }else if(indexPath.row == 5){
        SixViewController *sixVC = [[SixViewController alloc]init];
        [self.navigationController pushViewController:sixVC animated:YES];
    }else if(indexPath.row == 6){
        SevenViewController *sevenVC = [[SevenViewController alloc]init];
        [self.navigationController pushViewController:sevenVC animated:YES];
    }else if(indexPath.row == 7){
        EightViewController *eightVC = [[EightViewController alloc]init];
        [self.navigationController pushViewController:eightVC animated:YES];
    }else if(indexPath.row == 8){
        NinethViewController *nineVC = [[NinethViewController alloc]init];
        [self.navigationController pushViewController:nineVC animated:YES];
    }else if(indexPath.row == 9){
        TenthViewController *tenVC = [[TenthViewController alloc]init];
        [self.navigationController pushViewController:tenVC animated:YES];
    }

}
@end
