//
//  UIImage+Roam.h
//  RoamToolkit
//
//  Created by Stuart Austin on 22/01/15.
//  Copyright (c) 2015 Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import <UIKit/UIKit.h>

@interface UIImage (Roam)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize) size;

-(UIImage*)rotate:(UIImageOrientation)orient;

@end