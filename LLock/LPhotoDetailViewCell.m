//
//  LPhotoDetailViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoDetailViewCell.h"

static NSString *const reuseIdentifier = @"photoDetailCell";

static const CGFloat maxScale = 5;

@interface LPhotoDetailViewCell()

@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LPhotoDetailViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.contentView.backgroundColor = C_GRAY(0.1);
    
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initFullInSuperview:self.contentView];
    self.loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.loadingIndicator.hidesWhenStopped = YES;
    
    self.imageView = [[UIImageView alloc] initFullInSuperview:self.contentView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.clipsToBounds = YES;
    
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
//    [self addGestureRecognizer:pinch];
    
    return self;
}

#pragma mark - Getters

- (UIImageView *)viewForZooming {
    return self.imageView;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

#pragma mark - Setters

- (void)setPhotoId:(NSNumber *)photoId {
    
    // Load photo image
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

#pragma mark - GestureRecognizer

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    
    CGFloat scale = gesture.scale - 1;
    while (scale >= 1) {
        scale -= 1;
    }
    LOG(@"PINCH %.2f %.2f", scale, gesture.velocity);
    
    if (scale < 0 && self.imageView.scale + scale >= 1) {
        self.imageView.scale += scale;
    }
    else if (scale > 0 && self.imageView.scale + scale <= maxScale) {
        self.imageView.scale += scale;
    }
}

@end
