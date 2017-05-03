//
//  UPClipImageVC.h
//  UploadProject
//
//  Created by 王林 on 2017/5/3.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UPClipImageVC;
@protocol UPClipImageVCDelegate <NSObject>

- (void)ClipImageVC: (UPClipImageVC *)clipImageVC didFinish:(UIImage *)editImage;
- (void)ClipImageVCDidCancel:(UPClipImageVC *)clipImageVC;

@end

@interface UPClipImageVC : UIViewController

@property (strong, nonatomic)UIImage *clipImage;
@property (weak, nonatomic) id<UPClipImageVCDelegate> delegate;



@end
