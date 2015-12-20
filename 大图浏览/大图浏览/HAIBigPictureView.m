//
//  HAIBigPictureView.m
//  大图浏览
//
//  Created by 黄成都 on 15/12/19.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HAIBigPictureView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HAIBigPictureView ()<UIScrollViewDelegate>
{
    CGFloat startContentOffsetX;
    CGFloat endContentOffsetX;
}
//总共三个，存放大图的列表
@property(nonatomic,strong)NSMutableArray *imageViewArray;
//大图选中的索引
@property(nonatomic,assign)NSInteger currentIndex;
//大图列表对应数组
@property(nonatomic,strong)NSArray *URLStringArray;
//大图列表的scrollview
@property(nonatomic,strong)UIScrollView *scrollView;
//当前屏幕上显示的图片对应的imageview
@property(nonatomic,strong)UIImageView *currentImageView;
//右上角的3/5标签
@property(nonatomic,strong)UILabel *countLable;
//图文详情
@property(nonatomic,strong)UIButton *detailButton;
//================针对多图情况====================
//下面的小图地址列表
@property(nonatomic,strong)NSArray *smallPictureArray;
//大图的地址列表，每个对象也是数组
@property(nonatomic,strong)NSArray *bigPictureArray;
//当前选中的小图索引
@property(nonatomic,assign)NSInteger currentSmallIndex;
//小图的背景视图
@property(nonatomic,strong)UIScrollView *smallScrollView;
//颜色：3
@property(nonatomic,strong)UILabel *smallTitleLable;
@end


@implementation HAIBigPictureView

-(instancetype)initWithBigPictureArray:(NSArray *)pictureArray currentIndex:(NSInteger)currentIndex{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        //这里我取一个默认值
        self.headerHieght = 80;
        self.bottowHeight = 80;
        self.URLStringArray = pictureArray;
        self.currentIndex = currentIndex;
        [self setUpCommonView];
    }
    return self;
}

-(instancetype)initWithSmallPictureArray:(NSArray *)smallPictureArray bigPictrueArray:(NSArray *)bigPictureArray currentIndex:(NSInteger)currentIndex smallIndex:(NSInteger)smallIndex{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.headerHieght = 60;
        self.bottowHeight = 140;
        self.bigPictureArray = bigPictureArray;
        //取出当前小图索引对应的大图的列表索引。
        self.URLStringArray = self.bigPictureArray[smallIndex];
        self.smallPictureArray = smallPictureArray;
        self.currentIndex = currentIndex;
        self.currentSmallIndex = smallIndex;
        
        [self setUpCommonView];
        
        
        UIView *backGroundView = [[UIView alloc]init];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];
        [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.scrollView.mas_bottom);
        }];
        //颜色：3
        self.smallTitleLable = [[UILabel alloc]init];
        self.smallTitleLable.font = [UIFont systemFontOfSize:15];
        self.smallTitleLable.textColor = [UIColor lightGrayColor];
        self.smallTitleLable.textAlignment = NSTextAlignmentLeft;
        self.smallTitleLable.text = [NSString stringWithFormat:@"颜色:%ld",self.currentSmallIndex];
        [backGroundView addSubview:self.smallTitleLable];
        [self.smallTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(15);
        }];

        self.smallScrollView = [[UIScrollView alloc]init];
        self.smallScrollView.layer.borderColor = [UIColor greenColor].CGColor;
        self.smallScrollView.layer.borderWidth = 1;
        [backGroundView addSubview:self.smallScrollView];
        [self.smallScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(backGroundView);
            make.top.equalTo(self.smallTitleLable.mas_bottom);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(backGroundView.mas_bottom);
        }];
        //初始化小图列表
        UIImageView *lastImageView = nil;
        UIImageView *smallImageView;
        for (NSInteger index = 0; index < self.smallPictureArray.count; index++) {
            smallImageView = [[UIImageView alloc]init];
            smallImageView.tag = index;
            smallImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSmallImageView:)];
            [smallImageView addGestureRecognizer:gesture];
            smallImageView.layer.borderColor = [UIColor greenColor].CGColor;
            smallImageView.layer.borderWidth = 1;
            NSURL *smallURL = [NSURL URLWithString:self.smallPictureArray[index]];
            [smallImageView sd_setImageWithURL:smallURL placeholderImage:nil];
            [self.smallScrollView addSubview:smallImageView];
            if (lastImageView) {
                [smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(self.smallScrollView);
                    make.left.equalTo(lastImageView.mas_right).with.offset(10);
                    make.width.mas_equalTo(40);
                }];
                lastImageView = smallImageView;

            }else{
                [smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(self.smallScrollView);
                    make.width.mas_equalTo(40);
                }];
                lastImageView = smallImageView;
            }
        }
        
    }
    return self;

}
#pragma mark 一些通用视图的初始化
-(void)setUpCommonView{
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.mas_equalTo(self.headerHieght);
        make.bottom.equalTo(self.mas_bottom).with.offset(-self.bottowHeight);
    }];
    //初始化大图浏览中的三个imageview
    self.imageViewArray = [NSMutableArray array];
    for (NSInteger index = 0; index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageView:)];
        [imageView addGestureRecognizer:gesture];
        imageView.layer.borderColor = [UIColor greenColor].CGColor;
        imageView.layer.borderWidth = 1;
        [self.scrollView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((self.currentIndex - 1 + index) * kScreenWidth);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.equalTo(self.scrollView.mas_height);
        }];
        if (index == 1) {
            self.currentImageView = imageView;
        }
        [self.imageViewArray addObject:imageView];
    }
    //初始化 3/5标签
    self.countLable = [[UILabel alloc]init];
    self.countLable.font = [UIFont systemFontOfSize:15];
    self.countLable.textColor = [UIColor lightGrayColor];
    self.countLable.textAlignment = NSTextAlignmentRight;
    self.countLable.text = [NSString stringWithFormat:@"%ld/%ld",(self.currentIndex + 1),self.URLStringArray.count];
    [self.scrollView addSubview:self.countLable];
    [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((self.currentIndex + 1) * kScreenWidth - 80);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    //初始化图文详情
    self.detailButton = [[UIButton alloc]init];
    [self.detailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.detailButton.backgroundColor = [UIColor whiteColor];
    self.detailButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.detailButton.titleLabel.numberOfLines = 0;
    [self.detailButton setTitle:@"图文\n详情" forState:UIControlStateNormal];
    [self.detailButton addTarget:self action:@selector(clickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.detailButton];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-16);
        make.bottom.equalTo(self.mas_bottom).with.offset(-16);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.detailButton.layer.cornerRadius = 25;
}
#pragma mark 开始加载
-(void)startLoad{
    [self private_loadImages];
}

#pragma mark 做一些初始化的操作
-(void)private_loadImages{
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.URLStringArray.count, kScreenHeight - self.headerHieght - self.bottowHeight );
    self.scrollView.contentOffset =CGPointMake(self.currentIndex * kScreenWidth, 0);

    for (NSInteger index = 0; index < 3; index++) {
        UIImageView *imageView = self.imageViewArray[index];
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((self.currentIndex - 1 + index) * kScreenWidth);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.equalTo(self.scrollView.mas_height);
        }];
    }

    self.currentImageView = self.imageViewArray[1];
    NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex]];
    self.currentImageView.tag = self.currentIndex;
    [self.currentImageView sd_setImageWithURL:url placeholderImage:nil];
    
    UIImageView *latterImageView = self.imageViewArray[2];
    latterImageView.tag = self.currentIndex + 1;
    if (self.currentIndex < (self.URLStringArray.count - 1)) {
        NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex + 1]];
        [latterImageView sd_setImageWithURL:url placeholderImage:nil];
    }else{
        latterImageView.image = nil;
    }
    UIImageView *formerImageView = self.imageViewArray[0];
    formerImageView.tag = self.currentIndex - 1;
    if (self.currentIndex > 0) {
        NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex - 1]];
        [formerImageView sd_setImageWithURL:url placeholderImage:nil];
    }else{
        formerImageView.image = nil;
    }

}
#pragma mark 点击大图
-(void)clickImageView:(UITapGestureRecognizer *)gesture{
    NSLog(@"大图索引：%ld",gesture.view.tag);
}
#pragma mark 点击小图
-(void)clickSmallImageView:(UITapGestureRecognizer *)gesture{
    NSLog(@"小图索引：%ld",gesture.view.tag);
    self.currentIndex = gesture.view.tag;
    self.currentSmallIndex = gesture.view.tag;
    self.URLStringArray = self.bigPictureArray[self.currentSmallIndex];
    //更新视图的位置
    [self private_loadImages];
    //重新设置3/5的位置
    [self.countLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((self.currentIndex + 1) * kScreenWidth - 80);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    self.countLable.text = [NSString stringWithFormat:@"%ld/%ld",(self.currentIndex + 1),self.URLStringArray.count];
    //设置颜色：3的新值
    self.smallTitleLable.text = [NSString stringWithFormat:@"颜色:%ld",self.currentSmallIndex];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    startContentOffsetX = scrollView.contentOffset.x;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    endContentOffsetX = scrollView.contentOffset.x;
    if (endContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
        [self changLayoutToRight:NO];
    } else if (endContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
        [self changLayoutToRight:YES];
    }
}

-(void)changLayoutToRight:(BOOL)toRight{
    if (toRight) {//向右滚动。把第一个imageview的位置移动到最后。
        UIImageView *firstImageView = self.imageViewArray[0];
        self.currentIndex = self.currentIndex + 1;
        [firstImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((self.currentIndex + 1) * kScreenWidth);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.equalTo(self.scrollView.mas_height);
        }];
        [self.imageViewArray removeObjectAtIndex:0];
        [self.imageViewArray addObject:firstImageView];
        firstImageView.tag = self.currentIndex + 1;
        if (self.currentIndex < (self.URLStringArray.count - 1)) {
            NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex + 1]];
            [firstImageView sd_setImageWithURL:url placeholderImage:nil];
        }else{
            firstImageView.image = nil;
        }
    }else{//向左滚动，需要修改最后一个imageview移动到第一个
        UIImageView *firstImageView = self.imageViewArray[2];
        self.currentIndex = self.currentIndex - 1;
        [firstImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((self.currentIndex - 1) * kScreenWidth);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
            make.height.equalTo(self.scrollView.mas_height);
        }];
        [self.imageViewArray removeObjectAtIndex:2];
        [self.imageViewArray insertObject:firstImageView atIndex:0];
        firstImageView.tag = self.currentIndex - 1;
        if (self.currentIndex > 0) {
            NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex - 1]];
            [firstImageView sd_setImageWithURL:url placeholderImage:nil];
        }else{
            firstImageView.image = nil;
        }
    }
    //从新设置1/5的位置和值
    [self.countLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((self.currentIndex + 1) * kScreenWidth - 80);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    self.countLable.text = [NSString stringWithFormat:@"%ld/%ld",(self.currentIndex + 1),self.URLStringArray.count];
}

#pragma mark 点击图文详情
-(void)clickDetailButton:(UIButton *)sender{
    NSLog(@"点击图文详情");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

-(void)dealloc{
    NSLog(@"移除");
}
@end
