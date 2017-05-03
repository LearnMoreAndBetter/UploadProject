//
//  UPClipImageVC.m
//  UploadProject
//
//  Created by 王林 on 2017/5/3.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "UPClipImageVC.h"
#import "CommonHeader.h"


@interface UPClipImageVC ()
{
	CGPoint _leftUpPoint;//左上角
	CGPoint _leftDownPoint;//左下角
	CGPoint _rightUpPoint;//右上角
	CGPoint _rightDownPoint;//右下角
}

@property (strong, nonatomic)UIView *clipView;
@property (strong, nonatomic)UIView *toolBar;
@property (strong, nonatomic)UIButton *editButton;
@property (strong, nonatomic)UIImageView *clipImageView;


@end

@implementation UPClipImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = @"上传头像";
	[self addGrandientLayer];
	
	[self addNavItems];
	
	[self addToolBar];
	
	[self addImageView];
	
	[self addGesture];
}

- (void)addGesture{
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget: self action:@selector(panGesture:)];
	[self.view addGestureRecognizer:pan];
}

- (void)panGesture:(UIPanGestureRecognizer *)pan {
	
	
}

- (void)addGrandientLayer{
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.colors = @[(__bridge id)[UIColor groupTableViewBackgroundColor].CGColor, (__bridge id)UP_MAIN_COLOR.CGColor, (__bridge id)[UIColor groupTableViewBackgroundColor].CGColor];
	gradientLayer.locations = @[@0.2, @0.6, @0.8];
	gradientLayer.startPoint = CGPointMake(0, 0);
	gradientLayer.endPoint = CGPointMake(0.0, 1.0);
	gradientLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:gradientLayer];
}

- (void)addImageView{
	self.clipImageView.image = self.clipImage;
	CGFloat scale = self.clipImage.size.width / self.clipImage.size.height;
	CGFloat padding = 8.f;
	CGFloat estimateWidth = APP_ScreenWidth - 2 * padding;
	CGFloat estimateHeight = APP_ScreenHeight - 64 - 49 - 2 * padding;
	CGFloat height = estimateWidth / scale;
	height = height < estimateHeight ? height : estimateHeight;
	CGFloat width = scale * height;
	self.clipImageView.frame = CGRectMake((estimateWidth - width)/2 + padding, (estimateHeight - height)/2 + 64 + padding, width, height);
	CGFloat clipWidth = width < height ? width : height;
	self.clipView.frame = CGRectMake(0, 0, clipWidth, clipWidth);
	self.clipView.center = self.clipImageView.center;
	
}

- (void)addNavItems{
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
	self.navigationItem.leftBarButtonItem.tintColor = UP_BLACK_COLOR;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
	self.navigationItem.rightBarButtonItem.tintColor = UP_BLACK_COLOR;
}

- (void)cancel{
	if (self.delegate && [self.delegate respondsToSelector:@selector(ClipImageVCDidCancel:)]) {
		[self.delegate ClipImageVCDidCancel:self];
	}
}

- (void)confirm{
	if (self.delegate && [self.delegate respondsToSelector:@selector(ClipImageVC:didFinish:)]) {
		[self.delegate ClipImageVC:self didFinish:self.clipImageView.image];
	}
}

- (void)addToolBar{
	self.toolBar.hidden = YES;
	self.editButton.hidden = NO;
}

#pragma mark- buttonAction
- (void)cancleEdit{
	self.toolBar.hidden = YES;
	self.editButton.hidden = NO;
	self.navigationController.navigationBar.hidden = NO;
	self.clipView.hidden = YES;
}

- (void)finishEdit{
	self.toolBar.hidden = YES;
	self.editButton.hidden = NO;
	self.navigationController.navigationBar.hidden = NO;
	self.clipView.hidden = YES;
}

- (void)editButtonAction{
	self.toolBar.hidden = NO;
	self.editButton.hidden = YES;
	self.navigationController.navigationBar.hidden = YES;
	self.clipView.hidden = NO;
}

#pragma mark- lazying
- (UIView *)toolBar{
	if (!_toolBar) {
		_toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, APP_ScreenHeight - 49, APP_ScreenWidth, 49)];
		_toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self.view addSubview:_toolBar];
		UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 49, 49)];
		[cancleButton setImage:[UIImage imageNamed:@"btn_cancle"] forState:UIControlStateNormal];
		[cancleButton addTarget:self action:@selector(cancleEdit) forControlEvents:UIControlEventTouchUpInside];
		[_toolBar addSubview:cancleButton];
		
		UIButton *finishButton = [[UIButton alloc]initWithFrame:CGRectMake(APP_ScreenWidth - 20 - 49, 0, 49, 49)];
		[finishButton setImage:[UIImage imageNamed:@"btn_ok"] forState:UIControlStateNormal];
		[finishButton addTarget:self action:@selector(finishEdit) forControlEvents:UIControlEventTouchUpInside];
		[_toolBar addSubview:finishButton];
	}
	return _toolBar;
}

- (UIButton *)editButton{
	if (!_editButton) {
		_editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, APP_ScreenHeight - 49, APP_ScreenWidth, 49)];
		[_editButton setTitle:@"编辑" forState:UIControlStateNormal];
		_editButton.backgroundColor = UP_MAIN_COLOR;
		[_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		_editButton.titleLabel.font = [UIFont systemFontOfSize:17];
		[_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:_editButton];
	}
	return _editButton;
}

- (UIImageView *)clipImageView{
	if (!_clipImageView) {
		_clipImageView = [[UIImageView alloc]init];
		_clipImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.view addSubview:_clipImageView];
	}
	return _clipImageView;
}

- (UIView *)clipView{
	if (!_clipView) {
		_clipView = [[UIView alloc] init];
		_clipView.backgroundColor = [UIColor clearColor];
//		_clipView.alpha = 0.2;
		_clipView.hidden = YES;
		_clipView.layer.borderWidth = 3.0;
		_clipView.layer.borderColor = [UIColor whiteColor].CGColor;
		[self.view addSubview:_clipView];
	}
	return _clipView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
