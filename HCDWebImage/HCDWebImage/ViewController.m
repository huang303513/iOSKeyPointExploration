//
//  ViewController.m
//  HCDWebImage
//
//  Created by yifan on 15/9/28.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "appModel.h"
#import "HCDExtension.h"
#import "UIImageView+HCDWebCache.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSArray *dataListArray;

@end

@implementation ViewController

-(NSArray *)dataListArray{
    if (nil == _dataListArray) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSMutableArray *modelArray = [NSMutableArray arrayWithContentsOfFile:path];
        for (int i = 0; i < 100; i++) {
            [modelArray addObjectsFromArray:[NSArray arrayWithContentsOfFile:path]];
        }
        for (NSDictionary *dic in modelArray) {
            appModel *model = [appModel objectWithKeyValues:dic];
            [tempArray addObject:model];
        }
        _dataListArray = [NSArray arrayWithArray:tempArray];
    }
    return _dataListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 44;
    [self.view addSubview:self.tableview];
    //NSLog(@"%@",self.dataListArray);
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"123445556";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    appModel *model = self.dataListArray[indexPath.row];
    [cell.imageView downImageWithString:model.icon placeHolder:[UIImage imageNamed:@"placeholder"] complete:^(UIImage *image) {
        
    }];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataListArray.count;
}
@end
