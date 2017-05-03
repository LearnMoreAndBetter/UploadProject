//
//  UPImageCollectView.h
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//
//实现页面展示
#import <UIKit/UIKit.h>

typedef void(^UPAddImageBlock)();
typedef void(^UPDeleteImageBlock)(NSInteger);

@interface UPImageCollectView : UIView

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imageLists;
@property (copy, nonatomic) UPAddImageBlock imageBlock;
@property (copy, nonatomic) UPDeleteImageBlock deleteBlock;

- (CGFloat)collectionViewHeight;

@end
