//
//  UPImageCollectionViewCell.m
//  UploadProject
//
//  Created by 王林 on 2017/5/2.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "UPImageCollectionViewCell.h"

@implementation UPImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	self.upDetailLabel.adjustsFontSizeToFitWidth = YES;
}

@end
