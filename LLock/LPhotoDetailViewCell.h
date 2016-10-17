//
//  LPhotoDetailViewCell.h
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPhotoDetailViewCell : UICollectionViewCell

@property (nonatomic) NSNumber *photoId;

- (UIImageView *)viewForZooming;

+ (NSString *)reuseIdentifier;

@end
