//
//  ViewController.m
//  MCScrollCardDemo
//
//  Created by mac on 12/26/15.
//  Copyright © 2015 mc. All rights reserved.
//

#import "ViewController.h"
#import "MCMastorBoard.h"
#import "MCCardBoard.h"
#import "MCScrollBoard.h"
#import <Masonry/Masonry.h>
#import "MCPlanModel.h"
@interface ViewController ()<MCCardBoardTouchClickDelegate>{
    MCMastorBoard                       * _mastorBoard;                     ///< 滚动UI板
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _mastorBoard = [[MCMastorBoard alloc] init];
    _mastorBoard.backgroundColor = [UIColor redColor];
    [self.view addSubview:_mastorBoard];
    [_mastorBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
    }];
    
    [_mastorBoard setDataArr:[self modelData] responseClickDelegate:self];


}

-(nonnull NSArray<MCPlanModel*>*)modelData{
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    NSArray *picArr = @[@"http://www.gs.xinhuanet.com/news/2007-03/02/xin_400304021406750247202.jpg",
                        @"http://img.article.pchome.net/00/36/63/54/pic_lib/s960x639/1920CSYJ_1001s960x639.jpg",
                        @"http://img2.imgtn.bdimg.com/it/u=643443791,2711789823&fm=21&gp=0.jpg",
                        @"http://img.popoho.com/UploadPic/2012-1/2012124191017397.jpg",
                        @"http://www.it.com.cn/edu/artdesign/photoshop/exap/2011/10/27/18/tupian_qianming1.jpg",
                        @"http://img4.duitang.com/uploads/blog/201307/01/20130701162022_s2fch.thumb.600_0.jpeg",
                        @"http://img2.imgtn.bdimg.com/it/u=3937058148,1469323932&fm=21&gp=0.jpg",
                        @"http://img.ph.126.net/wr3V-gQwuiaJe5lYpZUx7g==/2867667062745111739.jpg",
                        @"http://i1.sinaimg.cn/IT/digi/mp3/2011-08-31/1314776744_OuByWd.jpg",
                        @"http://pic.nipic.com/2008-02-29/200822994648973_2.jpg"];
    for(NSInteger i = 0 ;i< picArr.count ;i++){
        MCPlanModel *model = [[MCPlanModel alloc] init];
        model.Id = i;
        model.title = [NSString stringWithFormat:@"选项卡%ld",i];
        model.desc = @"";
        model.img = [picArr[i] copy];
        model.coursenums = i;
        model.studynums = i*100;
        [dataArr addObject:model];
        
    }
    
    return dataArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/***
 * 进入选项卡
 *
 */
-(void)cardBoardTouchClick:(id)model{
    LSLog(@"跳转");
}



@end
