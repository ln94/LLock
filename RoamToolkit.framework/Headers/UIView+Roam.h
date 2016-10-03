//
//  UIView+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoamGeometry.h"

#pragma mark - Edges

typedef NS_ENUM(NSInteger, UIViewEdge) {
    UIViewEdgeTop,
    UIViewEdgeRight,
    UIViewEdgeBottom,
    UIViewEdgeLeft
};


#pragma mark - Corners

typedef NS_ENUM(NSInteger, UIViewCorner) {
    UIViewCornerTopLeft,
    UIViewCornerTopRight,
    UIViewCornerBottomRight,
    UIViewCornerBottomLeft
};


#pragma mark - Directions

typedef NS_ENUM(NSInteger, UIViewDirection) {
    UIViewDirectionHorizontal,
    UIViewDirectionVertical
};


@interface UIView (Roam)

#pragma mark - Initialisers

- (id)initInSuperview:(UIView *)superview;

- (id)initFullInSuperview:(UIView *)superview;
- (id)initFullInSuperview:(UIView *)superview insets:(CGInsets)insets;

- (id)initInSuperview:(UIView *)superview frame:(CGRect)frame;
- (id)initInSuperview:(UIView *)superview frame:(CGRect)frame autoresizing:(UIViewAutoresizing)autoresizing;

- (id)initWithSize:(CGSize)size;

- (id)initInSuperview:(UIView *)superview size:(CGSize)size;
- (id)initInSuperview:(UIView *)superview size:(CGSize)size center:(CGPoint)center;

- (id)initCenterInSuperview:(UIView *)superview size:(CGSize)size;
- (id)initCenterInSuperview:(UIView *)superview size:(CGSize)size insets:(CGInsets)insets;

- (id)initInSuperview:(UIView *)superview edge:(UIViewEdge)edge length:(CGFloat)length;
- (id)initInSuperview:(UIView *)superview edge:(UIViewEdge)edge length:(CGFloat)length insets:(CGInsets)insets;

- (id)initInSuperview:(UIView *)superview edge:(UIViewEdge)edge size:(CGSize)size;
- (id)initInSuperview:(UIView *)superview edge:(UIViewEdge)edge size:(CGSize)size insets:(CGInsets)insets;

- (id)initInSuperview:(UIView *)superview corner:(UIViewCorner)corner size:(CGSize)size;
- (id)initInSuperview:(UIView *)superview corner:(UIViewCorner)corner size:(CGSize)size insets:(CGInsets)insets;

- (id)initRelativeToView:(UIView *)view edge:(UIViewEdge)edge length:(CGFloat)length;
- (id)initRelativeToView:(UIView *)view edge:(UIViewEdge)edge length:(CGFloat)length padding:(CGFloat)padding;
- (id)initRelativeToView:(UIView *)view edge:(UIViewEdge)edge length:(CGFloat)length insets:(CGInsets)insets;


#pragma mark - Frame

- (void)fill;
- (void)fillInsets:(CGInsets)insets;

- (void)setEdge:(UIViewEdge)edge length:(CGFloat)length;
- (void)setEdge:(UIViewEdge)edge length:(CGFloat)length insets:(CGInsets)insets;

- (void)setEdge:(UIViewEdge)edge size:(CGSize)size;
- (void)setEdge:(UIViewEdge)edge size:(CGSize)size insets:(CGInsets)insets;

- (void)setCorner:(UIViewCorner)corner size:(CGSize)size;
- (void)setCorner:(UIViewCorner)corner size:(CGSize)size insets:(CGInsets)insets;

- (void)centerWithSize:(CGSize)size;
- (void)centerWithSize:(CGSize)size insets:(CGInsets)insets;

#pragma mark - Pin

- (void)pinToEdge:(UIViewEdge)edge;
- (void)pinToCorner:(UIViewCorner)corner;
- (void)pinToCenter;


#pragma mark - Scale

@property (nonatomic) CGFloat scale;


#pragma mark - Rotation

@property (nonatomic) CGFloat rotation;


#pragma mark - Origin

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;


#pragma mark - Center

- (void)centerInSuperview;
- (void)centerInSuperviewInsets:(CGInsets)insets;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


#pragma mark - Middle

@property (nonatomic, readonly) CGPoint middle;


#pragma mark - Size

@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;


#pragma mark - Edges

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;


#pragma mark - Distances

@property (nonatomic) CGFloat distanceTop;
@property (nonatomic) CGFloat distanceRight;
@property (nonatomic) CGFloat distanceBottom;
@property (nonatomic) CGFloat distanceLeft;


#pragma mark - Distribute subviews

- (void)distributeSubviewsWithDirection:(UIViewDirection)direction;


#pragma mark - Stack subviews

- (void)stackSubviewsAgainstEdge:(UIViewEdge)edge;
- (void)stackSubviewsAgainstEdge:(UIViewEdge)edge insets:(CGInsets)insets;
- (void)stackSubviewsAgainstEdge:(UIViewEdge)edge insets:(CGInsets)insets spacing:(CGFloat)spacing;

@end
