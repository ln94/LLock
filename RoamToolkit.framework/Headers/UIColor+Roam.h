//
//  UIColor+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Roam)

+ (UIColor *)colorWith256Red:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;
+ (UIColor *)colorWith256Red:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(NSInteger)a;

+ (UIColor *)colorWithRGBA:(NSUInteger)hex;
+ (UIColor *)colorWithARGB:(NSUInteger)hex;
+ (UIColor *)colorWithRGB:(NSUInteger)hex;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

- (NSString *)hexString;

- (UIColor *)colorBrighterByFactor:(float)factor;
- (UIColor *)colorDarkerByFactor:(float)factor;
- (UIColor *)colorMultipliedBy:(float)multiplier;

- (UIColor *)colorByAddingFactor:(float)factor;

@property (nonatomic, readonly) CGFloat r;
@property (nonatomic, readonly) CGFloat g;
@property (nonatomic, readonly) CGFloat b;
@property (nonatomic, readonly) CGFloat a;

@end
