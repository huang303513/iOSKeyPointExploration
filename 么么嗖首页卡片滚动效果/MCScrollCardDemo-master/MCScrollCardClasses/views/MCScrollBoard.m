//
//  MCScrollBoard.m
//  MCScrollCard
//
//  Created by mac on 15/9/15.
//  Copyright © 2015年 mc. All rights reserved.
//

#import "MCScrollBoard.h"
#import "MCCardBoard.h"
#import <Masonry/Masonry.h>
#import "MCPlanModel.h"

#define MC_SC_PADDING_TOP 80
#define MC_SC_PADDING_LEFT 30
#define MC_SC_PADDING_RIGHT 20
#define MC_SC_PADDING_BOTTOM 50
float const MAX_TOP_BOTTOM_PADDING = 50.0;
#define MC_SC_WIDTH [UIScreen mainScreen].bounds.size.width-2*MC_SC_PADDING_LEFT

@implementation MCScrollBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _boards = [[NSMutableArray alloc] initWithCapacity:0];
//        self.pagingEnabled = YES;
        self.delegate = self;
        self.clipsToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    return self;
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"contentOffset"];
    LSLog(@"MCScrollBoard dealloc" );
}
-(void)setDataArr:(nonnull NSArray<MCPlanModel*> *)dataArr responseClickDelegate:(nullable id<MCCardBoardTouchClickDelegate>)delegate{
    //如果是重复的，则返回
    if (dataArr.count==_dataArr.count) {
        int sumComm=0;
        for(int i=0;i<dataArr.count;i++){
            if (dataArr[i].Id == _dataArr[i].Id ) {
                sumComm++;
            }
        }
        if (sumComm==dataArr.count) {
            return;
        }
    }
    
    //clear before
    for(UIView *view in _boards){
        [view removeFromSuperview];
    }
    
    [_boards removeAllObjects];
    
    _dataArr = dataArr;
    //初始化Card
    //count width
    if (_srvBoard ==nil) {
        _srvBoard = UIView.new;
        _srvBoard.backgroundColor = [UIColor blueColor];
        [self addSubview:_srvBoard];
        [_srvBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(@((MC_SC_WIDTH + MC_SC_PADDING_RIGHT) * dataArr.count));
        }];
    }
    
    [_srvBoard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((MC_SC_WIDTH + MC_SC_PADDING_RIGHT) * dataArr.count));
    }];
    
    //设置contentsize
    //创建board
    MCCardBoard *leftBoard = nil;
    for(id model in dataArr){
        MCCardBoard *board = [[MCCardBoard alloc] init];
        board.delegate = delegate;
        board.model = model;
        
        MCPlanModel *jrModel = model;
        //设置基本信息
        if (jrModel.Id>=0) {
            [board updateTitle:jrModel.title];
            [board updateCourseNumsWithCoursNum:[NSString stringWithFormat:@"%ld门课程",jrModel.coursenums]];
            [board updateStudyNumsWithStudyNumStr:[NSString stringWithFormat:@"%ld人学习",jrModel.studynums]];
            [board updateImgWithImgStr:jrModel.img];
        }
        [_boards addObject:board];
        [_srvBoard addSubview:board];
        [board mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_srvBoard).with.offset(MC_SC_PADDING_TOP);
            make.bottom.equalTo(_srvBoard).with.offset(-MC_SC_PADDING_BOTTOM);
            
            make.left.equalTo(leftBoard ? leftBoard.mas_right: _srvBoard.mas_left).with.offset(leftBoard?MC_SC_PADDING_RIGHT:MC_SC_PADDING_RIGHT/2.0);
            make.width.equalTo(@(MC_SC_WIDTH));
            //            make.right.equalTo(rightBoard ? rightBoard : contentView).with.offset(-MC_SC_PADDING);
            
        }];
        leftBoard = board;
    }
    self.contentOffset = CGPointZero;
}
- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark - scr delegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    LSLog(@"scrollViewWillEndDragging");
//    LSLog(@"%f---%f     %f-----%f",velocity.x,velocity.y,(*targetContentOffset).x,(*targetContentOffset).y);
    //
    //    scrollView.contentOffset=CGPointMake(<#CGFloat x#>, 0);
    //stop item center
    _cardBoardStauts = velocity.x>0? CardBoardFromLeft : CardBoardFromRight;
    _cardBoardStauts = velocity.x==0?CardBoardNone:_cardBoardStauts;
    
    _scrollviewSpeed = velocity.x;
    float pageSizeFactor = (*targetContentOffset).x / (MC_SC_WIDTH + MC_SC_PADDING_RIGHT);
    int pageSize = (pageSizeFactor - (int)pageSizeFactor)>.5?(int)(pageSizeFactor+1):(int)pageSizeFactor;
    
    float x = pageSize * (MC_SC_WIDTH + MC_SC_PADDING_RIGHT);
    (*targetContentOffset).x = x;
    
    _willScroContentOffset = (*targetContentOffset);
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    LSLog(@"scrollViewDidEndDragging");
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    LSLog(@"scrollViewWillBeginDecelerating");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    LSLog(@"DidEndDecelerating");
    return;
//    LSLog(@"%f---%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    float x = MC_SC_PADDING_RIGHT + MC_SC_WIDTH;
    NSInteger index = scrollView.contentOffset.x/x;
    MCCardBoard *toboard  = [self carBoardAtIndex:index];
    //动画展现
    [toboard onShow];
    //缩小之前版本
    NSInteger fromCBIndex = index+_cardBoardStauts;
    MCCardBoard *fromCardBoard = [self carBoardAtIndex:fromCBIndex];
    [fromCardBoard normal];
    
    MCCardBoard *bedBoard = [self carBoardAtIndex:index-_cardBoardStauts];
    
    [bedBoard normal];
    
    
}
-(MCCardBoard*)carBoardAtIndex:(NSInteger)index{
    if (index>=0&&index<_boards.count) {
        return _boards[index];
    }
    return nil;
}

-(MCCardBoard *)findCardBoardAtContentOffset:(CGPoint)contetnOffset{
    NSInteger index = contetnOffset.x/(MC_SC_PADDING_RIGHT + MC_SC_WIDTH);
    return [self carBoardAtIndex:index];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    NSLog(@"keypath --  %@ --------%@",keyPath,change);
    id oldValue = change[@"old"];
    id newValue = change[@"new"];
    
    CGPoint newPoint;
    CGPoint oldPoint;
    [ (NSValue*)oldValue getValue:&oldPoint];
    [newValue getValue:&newPoint];
    
    //位置决定当前3个Items的位置变化
    CGFloat x = newPoint.x;
    NSInteger curIndex  = x/(MC_SC_WIDTH + MC_SC_PADDING_RIGHT);
    if (x==0&&_dataArr.count>0) {
        MCCardBoard *curCBL = [self carBoardAtIndex:curIndex];
        MCCardBoard *curCB = [self carBoardAtIndex:curIndex+1];
        float paddFactorCon = x/(MC_SC_WIDTH + MC_SC_PADDING_RIGHT) - curIndex;
        float paddFactor = paddFactorCon>.5?.5:paddFactorCon;
        float paddFactorL = paddFactorCon<.5?0.0:paddFactorCon-.5;
        [curCB changeHeightWithPadding:MAX_TOP_BOTTOM_PADDING - MAX_TOP_BOTTOM_PADDING*paddFactor*2];
        [curCBL changeHeightWithPadding:MAX_TOP_BOTTOM_PADDING*paddFactorL*2];
        [_mdelegate changeBackgroundImg:_dataArr[0]];
        return;
    }
    _cardBoardStauts = (newPoint.x - oldPoint.x)>=0?CardBoardFromLeft:CardBoardFromRight;

    if (_cardBoardStauts==CardBoardFromLeft) {
//        NSLog(@"----------left---------");
        MCCardBoard *curCBL = [self carBoardAtIndex:curIndex];
        MCCardBoard *curCB = [self carBoardAtIndex:curIndex+1];
        float paddFactorCon = x/(MC_SC_WIDTH + MC_SC_PADDING_RIGHT) - curIndex;
        float paddFactor = paddFactorCon>.5?.5:paddFactorCon;
        float paddFactorL = paddFactorCon<.5?0.0:paddFactorCon-.5;
        [curCB changeHeightWithPadding:MAX_TOP_BOTTOM_PADDING - MAX_TOP_BOTTOM_PADDING*paddFactor*2];
        [curCBL changeHeightWithPadding:MAX_TOP_BOTTOM_PADDING*paddFactorL*2];
        if (_mdelegate&&[_mdelegate respondsToSelector:@selector(changeBackgroundImg:)]) {
            if (paddFactor==.5) {
                //超出区域
                if (curIndex+1>=_dataArr.count) {
                    return;
                }
//                LSLog(@"滚动到---%ld",curIndex+1);
                [_mdelegate changeBackgroundImg:_dataArr[curIndex+1]];
            }
            else if(paddFactor==.0){
//                [_mdelegate changeBackgroundImg:_dataArr[0]];
            }
        }
        
//        NSLog(@"~~~~~factor-left = %f~~~~~~",paddFactor);
    }
    else if(_cardBoardStauts==CardBoardFromRight){
//        LSLog(@"----------right---------");
        MCCardBoard *curCB = [self carBoardAtIndex:curIndex];
        MCCardBoard *curCBR = [self carBoardAtIndex:curIndex+1];
//        curCBR.layer.borderColor = [UIColor redColor].CGColor;
//        curCBR.layer.borderWidth = 3;
        float paddFactorCon = x/(MC_SC_WIDTH + MC_SC_PADDING_RIGHT) - curIndex;
        float paddFactor = paddFactorCon>=.5?1-paddFactorCon:.5;
        float paddFactorR = paddFactorCon>=.5?.5:paddFactorCon;
        [curCB changeHeightWithPadding:MAX_TOP_BOTTOM_PADDING - MAX_TOP_BOTTOM_PADDING*paddFactor*2];
        [curCBR changeHeightWithPadding:MAX_TOP_BOTTOM_PADDING - MAX_TOP_BOTTOM_PADDING*paddFactorR*2];
        if (paddFactor==.5&&_mdelegate&&[_mdelegate respondsToSelector:@selector(changeBackgroundImg:)]) {
            if (curIndex>=_dataArr.count) {
                return;
            }
            [_mdelegate changeBackgroundImg:_dataArr[curIndex]];
//            NSLog(@"+++++++++++times -- factor-right = %f~~~~~~",paddFactor);
        }
//         NSLog(@"~~~~~factor-right = %f~~~~~~",paddFactor);

    }
    else{
//        NSLog(@"----------center---------");
//        UIAccessibilityIsReduceTransparencyEnabled 8.0
        if (_mdelegate&&[_mdelegate respondsToSelector:@selector(changeBackgroundImg:)]) {
            [_mdelegate changeBackgroundImg:_dataArr[0]];
        }
    }
    
    
    
}


@end
