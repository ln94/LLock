//
//  LPhotoGridCollectionViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoGridCollectionViewCell.h"

static NSString *const reuseIdentifier = @"photoGridCell";

static const CGFloat kCellWidth = 93;

@interface LPhotoGridCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LPhotoGridCollectionViewCell

- (instancetype)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (!self) return nil;
    
    UIImageView *imageView = [[UIImageView alloc] initFullInSuperview:self];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    LOG(@"Cell Init");
    
    return self;
}

#pragma mark - Getters

+(NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)cellWidth {
    return kCellWidth;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.image = image;
}

@end
