//
//  UPImageCollectionViewCell.h
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const UPImageCollectionViewCellIdentifier = @"UPImageCollectionViewCellIdentifier";

@interface UPImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UILabel *upDetailLabel;

@end
