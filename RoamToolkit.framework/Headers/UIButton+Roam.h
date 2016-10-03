//
//  UIButton+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Roam)

@property (nonatomic) NSString *text;
@property (nonatomic) UIColor *textColor;

- (void)addTarget:(id)target action:(SEL)action;

@end
