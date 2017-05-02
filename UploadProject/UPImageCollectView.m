//
//  UPImageCollectView.m
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#define kMaxImageCount 9 //最大图片个数
#define kImageLineCount 3 //每行图片个数
#define kLineSpace 4.0    //间距

#import "UPImageCollectView.h"
#import "UPImageCollectionViewCell.h"

@interface UPImageCollectView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation UPImageCollectView

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		
		[self addSubview:self.collectionView];
		
	}
	return self;
}

- (void)layoutSubviews{
	[super layoutSubviews];
	self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.imageLists.count < kMaxImageCount ? (self.imageLists.count + 1) : kMaxImageCount;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	[collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([UPImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:UPImageCollectionViewCellIdentifier];
	UPImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UPImageCollectionViewCellIdentifier forIndexPath:indexPath];
	cell.contentView.backgroundColor = [UIColor whiteColor];
	
	cell.upImageView.image = nil;
	cell.upDetailLabel.text = nil;
	cell.upDetailLabel.backgroundColor = [UIColor clearColor];
	
	if (self.imageLists.count < kMaxImageCount && indexPath.item == self.imageLists.count) {
		cell.upImageView.backgroundColor = [UIColor greenColor];
		cell.upDetailLabel.text = [NSString stringWithFormat:@"最多上传%d张", kMaxImageCount];
		cell.upDetailLabel.backgroundColor = [UIColor grayColor];
	}else{
		cell.upImageView.image = self.imageLists[indexPath.item][@"image"];
	}
	
	
	return cell;
}
//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	CGFloat cellWidth = self.bounds.size.width/kImageLineCount - kLineSpace * (kImageLineCount - 1)/kImageLineCount;
	return CGSizeMake(cellWidth, cellWidth);
}

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	if (self.imageLists.count < kMaxImageCount && indexPath.item == self.imageLists.count) {
		NSLog(@"添加照片");
		if (self.imageBlock) {
			self.imageBlock();
		}
	}else{
		NSLog(@"删除照片");
		if (self.deleteBlock) {
			self.deleteBlock(indexPath.item);
		}
	}
}

- (CGFloat)collectionViewHeight{
	CGFloat cellWidth = self.bounds.size.width/kImageLineCount - kLineSpace;
	NSInteger items = self.imageLists.count < kMaxImageCount ? (self.imageLists.count  + 1) : kMaxImageCount;
	NSInteger row = (items + kImageLineCount - 1)/kImageLineCount;
	return row * (cellWidth + kLineSpace);
}

#pragma mark- getter
- (UICollectionView *)collectionView{
	if (!_collectionView) {
		//初始化
		UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
		[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
		[flowLayout setMinimumLineSpacing:kLineSpace];
		[flowLayout setMinimumInteritemSpacing:kLineSpace];
		_collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
		_collectionView.backgroundColor = [UIColor whiteColor];
		//设置代理
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		
		_collectionView.bounces = NO;
	}
	return _collectionView;
}

- (NSMutableArray *)imageLists{
	if (!_imageLists) {
		_imageLists = [NSMutableArray array];
	}
	return _imageLists;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
