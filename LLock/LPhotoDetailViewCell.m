//
//  LPhotoDetailViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoDetailViewCell.h"

static NSString *const reuseIdentifier = @"photoDetailCell";

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
    
    // Swipe gestures
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    return self;
}

#pragma mark - Getters

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
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

#pragma mark - Swipes 

- (void)swipeLeft {
    [self.delegate LPhotoDetailViewCell:self didSwipe:UISwipeGestureRecognizerDirectionLeft];
}

- (void)swipeRight {
    [self.delegate LPhotoDetailViewCell:self didSwipe:UISwipeGestureRecognizerDirectionRight];
}

@end
