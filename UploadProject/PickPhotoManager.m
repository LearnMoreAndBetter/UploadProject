//
//  PickPhotoManager.m
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "PickPhotoManager.h"

@interface PickPhotoManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation PickPhotoManager

static PickPhotoManager *pickPhotoManager;

+ (instancetype)pickPhotoManager
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		pickPhotoManager = [[PickPhotoManager alloc]init];
	});
	return pickPhotoManager;
}

- (void)pickPhotoWithSourceType:(UIImagePickerControllerSourceType)sourseType
{
	if(![UIImagePickerController isSourceTypeAvailable:sourseType]){
		if (sourseType == UIImagePickerControllerSourceTypeCamera) {
			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设备不支持！" message:nil preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
			[alertController addAction:cancleAction];
			[[PickPhotoManager pickPhotoManager].preController presentViewController:alertController animated:YES completion:nil];
		}
		return;
	}
	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;
	picker.sourceType = sourseType;
	[[PickPhotoManager pickPhotoManager].preController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 拍摄完成后或者选择相册完成后自动调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
	[[PickPhotoManager pickPhotoManager].preController dismissViewControllerAnimated:YES completion:nil];
	// 得到照片
	if (self.successBlock) {
		self.successBlock(info);
	}
}


@end
