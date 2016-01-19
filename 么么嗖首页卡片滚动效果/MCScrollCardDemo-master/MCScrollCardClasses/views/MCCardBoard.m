//
//  MCCardBoard.m
//  MCScrollCard
//
//  Created by mac on 15/9/15.
//  Copyright © 2015年 mc. All rights reserved.
//

#import "MCCardBoard.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#define DEBUG_SHOWBOARD_COLOR_BLOCK 0
#define DEBUG_SHOWBOARD_DATA_TEST 0

@interface MCCardBoard ()
/**内容放置view 类似于contentView的用法*/
@property (nonatomic,strong,nonnull) UIView * showBard;
/**头部图片*/
@property (nonatomic,strong,nonnull) UIImageView * imgvwHeader;
/**标题0*/
@property (nonatomic,strong,nonnull) UILabel * lbTitle0;
/**分割线*/
@property (nonatomic,strong,nonnull) UIView * vwLine;
/**标题1*/
@property (nonatomic,strong,nonnull) UILabel * lbTitle1;
/**标题2*/
@property (nonatomic,strong,nonnull) UILabel * lbTitle2;
@end


@implementation MCCardBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [self addGestureRecognizer:tap];
        
        
        _showBard = [[UIView alloc] init];
        [self addSubview:_showBard];
        
        _showBard.layer.masksToBounds = YES;
        _showBard.layer.cornerRadius = 5.0;
#if DEBUG&&0
        _showBard.backgroundColor = [UIColor orangeColor];
#endif
        _showBard.backgroundColor = MC_FONT_COLOR_WHITE;
        [_showBard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(50, 0, 50, 0));
        }];
        //placeholder pic
        _imgvwHeader = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _imgvwHeader.backgroundColor = MC_FONT_COLOR_GRAY_III;
        _imgvwHeader.contentMode = UIViewContentModeScaleAspectFill;
        _imgvwHeader.clipsToBounds = YES;
        _vwLine = [[UIView alloc] init];
        _lbTitle0 = [[UILabel alloc] init];
        _lbTitle1 = [[UILabel alloc] init];
        _lbTitle2 = [[UILabel alloc] init];
        
        [_showBard addSubview:_imgvwHeader];
        [_showBard addSubview:_lbTitle0];
        [_showBard addSubview:_vwLine];
        [_showBard addSubview:_lbTitle1];
        [_showBard addSubview:_lbTitle2];
        
        _vwLine.backgroundColor = MC_FONT_COLOR_GRAY_II;
        _lbTitle0.textAlignment = NSTextAlignmentCenter;
        _lbTitle1.textAlignment = NSTextAlignmentCenter;
        _lbTitle2.textAlignment = NSTextAlignmentCenter;

        _lbTitle0.font = [UIFont systemFontOfSize:MC_FONT_SIZE_DEFAULE_VI];
        _lbTitle1.font = [UIFont systemFontOfSize:MC_FONT_SIZE_DEFAULE_III];
        _lbTitle2.font = [UIFont systemFontOfSize:MC_FONT_SIZE_DEFAULE_III];
        
        _lbTitle0.textColor = MC_FONT_COLOR_GRAY_I;
        
        _lbTitle1.textColor = MC_FONT_COLOR_GRAY_I;
        _lbTitle2.textColor = MC_FONT_COLOR_GRAY_I;
        
        _lbTitle0.backgroundColor = MC_FONT_COLOR_WHITE;
        _lbTitle1.backgroundColor = MC_FONT_COLOR_WHITE;
        _lbTitle2.backgroundColor = MC_FONT_COLOR_WHITE;
        
        if([UIDevice currentDevice].systemVersion.floatValue<7.0){
            _lbTitle0.backgroundColor = [UIColor clearColor];
            _lbTitle1.backgroundColor = [UIColor clearColor];
            _lbTitle2.backgroundColor = [UIColor clearColor];
        }
        
#if DEBUG_SHOWBOARD_COLOR_BLOCK
        _imgvwHeader.backgroundColor = [UIColor blueColor];
        _lbTitle0.backgroundColor = [UIColor purpleColor];
        _lbTitle1.backgroundColor = [UIColor redColor];
        _lbTitle2.backgroundColor = [UIColor yellowColor];
#endif
        
#if DEBUG_SHOWBOARD_DATA_TEST
        _lbTitle0.text = @"前端学习计划";
        _lbTitle1.text = @"100门课程";
        _lbTitle2.text = @"1000000000000人学习";
        
        _imgvwHeader.image = [UIImage imageNamed:@"plan_placehoder.jpg"];
#endif
        
      
    
        float title0Top = 0.0;
        float title1Top = 0.0;
        if ([UIScreen mainScreen].bounds.size.height>640.0) {
            title0Top = 40.0;
            title1Top = -100;
        }
        else{
            title0Top = 20.0;
            title1Top = -50;
        }
        
        [_imgvwHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(@0);
            make.height.equalTo(_showBard.mas_height).multipliedBy(2/5.0);
        }];
        
        
        [_lbTitle0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgvwHeader.mas_bottom).with.offset(title0Top);
            make.left.and.right.equalTo(@0);
            make.height.equalTo(@40);
        }];
        
        [_vwLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbTitle0.mas_bottom).with.offset(10);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.equalTo(@1);
            make.width.mas_equalTo([_lbTitle0.text sizeWithAttributes:@{NSFontAttributeName:_lbTitle0.font}]);
        }];
        
        [_lbTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lbTitle2.mas_top).with.offset(-5-30);
            make.left.and.right.equalTo(@0);
            make.height.equalTo(@30);
        }];
        
        [_lbTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_showBard.mas_bottom).with.offset(title1Top);
            make.left.and.right.equalTo(@0);
            make.height.equalTo(@30);
        }];
        
        
    }
    return self;
}
-(void)onShow{
    [_showBard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
-(void)changeHeightWithPadding:(float)padding{
//    self.layer.transform = CATransform3DMakeRotation(0, 1, 1, 10);
    
    [_showBard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(padding, 0, padding, 0));
    }];
}
-(void)normal{
    [_showBard mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(50, 0, 50, 0));
    }];
}


-(void)tapClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(cardBoardTouchClick:)]) {
        [_delegate cardBoardTouchClick:_model];
    }
}

/**
* 更新主题名称
*/
-(void)updateTitle:(nullable NSString *)title{
    _lbTitle0.text = title;
    [_vwLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_lbTitle0.text sizeWithAttributes:@{NSFontAttributeName:_lbTitle0.font}]);
    }];
}

/**
 * 更新课程总数
 */
-(void)updateCourseNumsWithCoursNum:(nullable NSString*)coursNumStr{
    _lbTitle1.text = coursNumStr;
}

/**
 * 更新课程学习人数
 */
-(void)updateStudyNumsWithStudyNumStr:(nullable NSString*)studyNumStr{
    _lbTitle2.text = studyNumStr;
}

/**
 * 更新主题主图
 */
-(void)updateImgWithImgStr:(nullable NSString*)imgUrl{
#pragma mark  default pic
    [_imgvwHeader sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"jobroadbg_default@2x"]];
}




@end
