//
//  LPhotoGridViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoGridViewCell.h"

static NSString *const reuseIdentifier = @"photoGridCell";

static const CGFloat kCellWidth = 93;

@interface LPhotoGridViewCell()

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LPhotoGridViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.contentView.backgroundColor = C_GRAY(0.1);
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initFullInSuperview:self.contentView];
    self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    self.imageView = [[UIImageView alloc] initFullInSuperview:self.contentView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    return self;
}

#pragma mark - Getters

+ (NSString *)reuseIdentifier {
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
