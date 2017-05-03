//
//  CommonHeader.h
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

#define kUPMaxImageCount 9 //最大图片个数
#define kUPImageLineCount 3 //每行图片个数
#define kUPLineSpace 4.0    //间距

#define APP_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define APP_ScreenHeight [UIScreen mainScreen].bounds.size.height

// 颜色(RGB)
#define RGB(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//文字色- - 黑色
#define UP_BLACK_COLOR       [UIColor colorWithRed:105 / 255.0 green:105 / 255.0 blue:105 / 255.0 alpha:1]
//主色调－－深绿
#define UP_MAIN_COLOR        [UIColor colorWithRed:44 / 255.0 green:183 / 255.0 blue:124 / 255.0 alpha:1]

#endif /* CommonHeader_h */
