//
//  HAIBigPictureView.h
//  大图浏览
//
//  Created by 黄成都 on 15/12/19.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAIBigPictureView : UIView
/**
 *  初始化一个大图浏览对象。针对只有一组图片的情况
 *
 *  @param pictureArray 图片地址数组
 *  @param currentIndex 当前选中第几张图片，从0开始
 *
 *  @return 返回对象
 */
-(instancetype)initWithBigPictureArray:(NSArray *)pictureArray currentIndex:(NSInteger)currentIndex;
/**
 *  初始化一个大图浏览对象。针对有多组组图片的情况
 *
 *  @param smallPictureArray 底部小图片数组
 *  @param bigPictureArray   上面大图片数组，数组中的每个对象也是一个数组，即一个选中的小图片对应的大图片列表
 *  @param currentIndex      选中的大图片索引，从0开始
 *  @param smallIndex        选中的小图片索引，从0开始
 *
 *  @return 图片浏览对象
 */
-(instancetype)initWithSmallPictureArray:(NSArray *)smallPictureArray  bigPictrueArray:(NSArray *)bigPictureArray currentIndex:(NSInteger)currentIndex smallIndex:(NSInteger)smallIndex;
//顶部透明的高度
@property(nonatomic,assign)CGFloat headerHieght;
//底部透明的高度
@property(nonatomic,assign)CGFloat bottowHeight;
//开始加载
-(void)startLoad;

@end
