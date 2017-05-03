//
//  UploadImageVC+UploadImage.m
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "UploadImageVC+UploadImage.h"
#import <objc/runtime.h>
#import "PickPhotoManager.h"


static const void *DeleteIndexKey = &DeleteIndexKey;

@implementation UploadImageVC (UploadImage)

- (void)setDeleteIndex:(NSNumber *)deleteIndex{
	objc_setAssociatedObject(self, DeleteIndexKey, deleteIndex, OBJC_ASSOCIATION_ASSIGN);
}

- (NSNumber *)deleteIndex{
	return  objc_getAssociatedObject(self, DeleteIndexKey);
}

- (void)uploadAction{
	[self uploadAlertShow];
}

- (void)deleteAction:(NSInteger)index{
	if (index < 0 || index >= self.displayView.imageLists.count) {
		return;
	}
	[self deleteAlertShow];
}

- (void)updateDisplayViewFrame{
	self.displayView.frame = CGRectMake(CGRectGetMinX(self.displayView.frame), CGRectGetMinY(self.displayView.frame), CGRectGetWidth(self.displayView.frame), [self.displayView collectionViewHeight]);
}

- (void)reloadDisplayView{
	[self updateDisplayViewFrame];
	[self.displayView.collectionView reloadData];
}

- (void)uploadAlertShow{
	[PickPhotoManager pickPhotoManager].preController = self;
	[PickPhotoManager pickPhotoManager].successBlock = ^(NSDictionary *info)
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
			
			UPClipImageVC *imageVC = [[UPClipImageVC alloc]init];
			imageVC.clipImage = image;
			imageVC.delegate = self;
			UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imageVC];
			[self presentViewController:nav animated:YES completion:nil];
		});
	};
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		[[PickPhotoManager pickPhotoManager] pickPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera];
	}];
	UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[[PickPhotoManager pickPhotoManager] pickPhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	}];
	UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	
	[alertController addAction:cameraAction];
	[alertController addAction:photoLibraryAction];
	[alertController addAction:cancleAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)deleteAlertShow{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除该照片？" message:nil preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		[self.displayView.imageLists removeObjectAtIndex:[self.deleteIndex integerValue]];
		[self reloadDisplayView];
	}];
	UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
	[alertController addAction:cancleAction];
	[alertController addAction:deleteAction];
	[self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark- UPClipImageVCDelegate
- (void)ClipImageVCDidCancel:(UPClipImageVC *)clipImageVC{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ClipImageVC:(UPClipImageVC *)clipImageVC didFinish:(UIImage *)editImage{
	[self dismissViewControllerAnimated:YES completion:^{
		[self.displayView.imageLists addObject:editImage];
		[self reloadDisplayView];
	}];
}

@end
