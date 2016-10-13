//
//  LPhotoDetailViewCell.h
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPhotoDetailViewCellDelegate;

@interface LPhotoDetailViewCell : UICollectionViewCell

@property (nonatomic) NSNumber *photoId;

@property (nonatomic) id<LPhotoDetailViewCellDelegate> delegate;

+ (NSString *)reuseIdentifier;

@end

@protocol LPhotoDetailViewCellDelegate <NSObject>

- (void)LPhotoDetailViewCell:(LPhotoDetailViewCell *)cell didSwipe:(UISwipeGestureRecognizerDirection)direction;

@end
