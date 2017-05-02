//
//  PickPhotoManager.h
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//
//实现选择照片功能

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^PickPhotoSuccessBlock)(NSDictionary *);

@interface PickPhotoManager : NSObject

@property (nonatomic,copy) PickPhotoSuccessBlock successBlock;

@property (nonatomic,weak) UIViewController *preController;

-(void)pickPhotoWithSourceType:(UIImagePickerControllerSourceType)sourseType;

+ (instancetype)pickPhotoManager;

@end
