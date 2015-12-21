//
//  YKMacro.h
//  YKProduct
//
//  Created by Tinnen on 11-10-20.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#define KEY_CACHE 10

#define WIDTH_FULL_SCREEN 320.0f
#define HEIGHT_FULL_SCREEN 480.0f

#define WHETHERTABLEHIDDEN(_TABLE, _IMAGE, _WHETHER, _RESETEDITING) { _TABLE.hidden = _WHETHER; _IMAGE.hidden = !_WHETHER; if ( [_TABLE isKindOfClass:[UITableView class]] ) { _TABLE.editing = _RESETEDITING ? NO : _TABLE.editing; } }


#define FRAME_FULL_SCREEN  CGRectMake(0.f, 0.f, WIDTH_FULL_SCREEN, HEIGHT_FULL_SCREEN)


//====================================================
// 用途: 判断字符串是否为空
//====================================================
#define strIsEmpty(str) (str == nil || [str length]<1 ? YES : NO )

//====================================================
// 用途: release
//====================================================
#define YK_RELEASE_SAFELY(__POINTER) { if (__POINTER) { [__POINTER release]; __POINTER = nil; } }
//#define YK_RELEASE_SAFELY(__POINTER) { if (__POINTER) { [__POINTER release]; __POINTER = nil; } }



//====================================================
// 用途: color
//====================================================
//#define RGBACOLOR(_r, _g, _b, _a) [UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:(_a)]


//====================================================
// 用途: 判断屏幕是否是高清屏幕
//====================================================
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//====================================================
// 用途: test
//====
//====================================================
#define SYSVERSION [[[UIDevice currentDevice] systemVersion] floatValue]


//====================================================
// 用途: test
//====
//====================================================
  #define TEST_RETAINCOUNT_POINT(__ARRAY) { for (int i = 0 ; i < [(__ARRAY) count]; ++i) { NSLog(@"(%i)", [[(__ARRAY) objectAtIndex:i] retainCount]); } }  

//图片的名字
#define IMG_PUBLIC_SwitchBtn_Normal             @"ShopCity_send"
#define IMG_PUBLIC_SwitchBtn_Highlight          @"06_btn_search_selected.png"
#define IMG_PUBLIC_SearchBg                     @"ShopCity_SearchBg"
#define IMG_PUBLIC_TextBg                       @"06_search_editor.png"
#define IMG_PUBLIC_SearchIcon                   @"06_img_search.png"
