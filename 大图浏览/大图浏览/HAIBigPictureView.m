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
@property(nonatomic,strong)NSMutableArray *imageViewArray;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)NSArray *URLStringArray;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *formerImageView;
@property(nonatomic,strong)UIImageView *currentImageView;
@property(nonatomic,strong)UIImageView *latterImageView;
@end


@implementation HAIBigPictureView

-(instancetype)initWithBigPictureArray:(NSArray *)pictureArray currentIndex:(NSInteger)currentIndex{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.URLStringArray = pictureArray;
        self.currentIndex = currentIndex;
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.scrollView = [[UIScrollView alloc]init];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.mas_equalTo(80);
            make.bottom.equalTo(self.mas_bottom).with.offset(-80);
        }];
        //[self layoutIfNeeded];
       // NSLog(@"scrollView = %@",NSStringFromCGRect(self.scrollView.frame));
        self.imageViewArray = [NSMutableArray array];
        for (NSInteger index = 0; index < 3; index++) {
            UIImageView *imageView = [[UIImageView alloc]init];
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
            }else if(index == 0){
                self.formerImageView = imageView;
            }else{
                self.latterImageView = imageView;
            }
            //[self layoutIfNeeded];
            //NSLog(@"scrollView = %@",NSStringFromCGRect(imageView.frame));

            [self.imageViewArray addObject:imageView];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //
    //NSLog(@"scrollView = %@",NSStringFromCGRect(self.scrollView.frame));
    //NSLog(@"scrollView = %@",NSStringFromCGRect(self.currentImageView.frame));
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.URLStringArray.count, kScreenHeight - 160);
    if (self.currentIndex > 0) {
        self.scrollView.contentOffset =CGPointMake(self.currentIndex * kScreenWidth, 0);
    }
    
}

-(void)startLoad{
    //self.currentImageView = self.imageViewArray[1];
//    [self.currentImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(kScreenWidth * self.currentIndex);
//    }];
    [self private_loadImages];
}


-(void)private_loadImages{
    NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex]];
    self.currentImageView.tag = self.currentIndex;
    [self.currentImageView sd_setImageWithURL:url placeholderImage:nil];
    self.latterImageView.tag = self.currentIndex + 1;
    if (self.currentIndex < (self.URLStringArray.count - 1)) {
        NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex + 1]];
        [self.latterImageView sd_setImageWithURL:url placeholderImage:nil];
    }
    self.formerImageView.tag = self.currentIndex - 1;
    if (self.currentIndex > 0) {
        NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex - 1]];
        [self.formerImageView sd_setImageWithURL:url placeholderImage:nil];
    }

}

-(void)clickImageView:(UITapGestureRecognizer *)gesture{
    NSLog(@"%ld",gesture.view.tag);
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    
    startContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    
    //willEndContentOffsetX = scrollView.contentOffset.x;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    endContentOffsetX = scrollView.contentOffset.x;
    
    if (endContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
        //self.currentIndex = self.currentIndex - 1;
        [self changLayoutToRight:NO];
    } else if (endContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
        //self.currentIndex = self.currentIndex + 1;
        [self changLayoutToRight:YES];
    }
    //[self private_loadImages];
}

-(void)changLayoutToRight:(BOOL)toRight{
    if (toRight) {
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
        //[self.imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
        firstImageView.tag = self.currentIndex + 1;
        if (self.currentIndex < (self.URLStringArray.count - 1)) {
            NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex + 1]];
            [firstImageView sd_setImageWithURL:url placeholderImage:nil];
        }else{
            firstImageView.image = nil;
        }
    }else{
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
        //[self.imageViewArray exchangeObjectAtIndex:0 withObjectAtIndex:2];
        firstImageView.tag = self.currentIndex - 1;
        if (self.currentIndex > 0) {
            NSURL *url = [NSURL URLWithString:self.URLStringArray[self.currentIndex - 1]];
            [firstImageView sd_setImageWithURL:url placeholderImage:nil];
        }else{
            firstImageView.image = nil;
        }
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

-(void)dealloc{
    NSLog(@"移除");
}
@end
