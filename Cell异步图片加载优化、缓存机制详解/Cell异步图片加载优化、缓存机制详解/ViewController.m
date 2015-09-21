//
//  ViewController.m
//  Cell异步图片加载优化、缓存机制详解
//
//  Created by yifan on 15/9/21.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSArray *dataListArray;

@end

@implementation ViewController

-(NSArray *)dataListArray{
    if (nil == _dataListArray) {
        
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 44;
    self.tableview.style = UITableViewStylePlain;
    [self.view addSubview:self.tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
