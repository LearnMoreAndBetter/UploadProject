//
//  UploadImageVC+UploadImage.h
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//
//分类实现添加删除图片功能
#import "UploadImageVC.h"

@interface UploadImageVC (UploadImage)

@property (assign, nonatomic)NSNumber *deleteIndex;//删除第几张照片

- (void)uploadAction;	//上传图片
- (void)deleteAction:(NSInteger)index;//删除图片
- (void)updateDisplayViewFrame; //更新frame


@end
