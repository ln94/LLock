//
//  LPhotoGridCollectionViewCell.h
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPhotoGridCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

+ (NSString *)reuseIdentifier;
+ (CGFloat)cellWidth;

@end
