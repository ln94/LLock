//
//  LPinDotView.m
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPinDotView.h"

static const CGFloat width = 20;

@interface LPinDotView ()

@property (nonatomic) UIView *line;
@property (nonatomic) UIView *circle;

@end

@implementation LPinDotView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    // Line
    self.line = [[UIView alloc] initCenterInSuperview:self size:s(width, 2)];
    self.line.backgroundColor = C_MAIN_WHITE;
    
    // Circle
    self.circle = [[UIView alloc] initCenterInSuperview:self size:size_square(width)];
    self.circle.layer.cornerRadius = width / 2;
    self.circle.backgroundColor = C_MAIN_WHITE;
    
    self.entered = NO;
    
    return self;
}

+ (CGFloat)width {
    return width;
}

- (void)setEntered:(BOOL)entered {
    _entered = entered;
    
    self.line.hidden = entered;
    self.circle.hidden = !entered;
}
@end
