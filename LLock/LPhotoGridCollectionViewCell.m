//
//  LPhotoGridCollectionViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoGridCollectionViewCell.h"

static NSString *const reuseIdentifier = @"photoGridCell";

static const CGFloat kCellWidth = 92;

@interface LPhotoGridCollectionViewCell()

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LPhotoGridCollectionViewCell

- (instancetype)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (!self) return nil;
    
    self.contentView.backgroundColor = C_DARK_GRAY;
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initFullInSuperview:self.contentView];
    self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    self.imageView = [[UIImageView alloc] initFullInSuperview:self.contentView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
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

- (void)setPhotoId:(NSNumber *)photoId {
    
    self.imageView.image = nil;
    [self.loadingIndicator startAnimating];
    
    run_background(^{
        LPhotoImage *image = [LPhotoImage firstWithKey:@"photoId" value:photoId];
        run_main(^{
            self.imageView.image = (UIImage *)image.fullImage;
            [self.loadingIndicator stopAnimating];
        });
    });
}

@end
