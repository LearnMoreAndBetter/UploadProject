//
//  UploadImageVC.m
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "UploadImageVC.h"
#import "UploadImageVC+UploadImage.h"

@interface UploadImageVC ()

@end

@implementation UploadImageVC

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	self.title = @"上传照片";
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[self.view addSubview:self.displayView];
	[self updateDisplayViewFrame];
	
	[self upImageBlockAction];
}

- (void)upImageBlockAction{
	__weak typeof(self) weakSelf = self;
	self.displayView.imageBlock = ^{
		[weakSelf uploadAction];
	};
	self.displayView.deleteBlock = ^(NSInteger index){
		[weakSelf deleteAction:index];
	};
}


- (UPImageCollectView *)displayView{
	if (!_displayView) {
		_displayView = [[UPImageCollectView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 120)];
	}
	return _displayView;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
