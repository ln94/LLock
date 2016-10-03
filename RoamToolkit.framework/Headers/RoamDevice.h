//
//  RoamDevice.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#define IS_PHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD    (!IS_PHONE)

#define IS_4_INCH (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)

#define DEVICE_ORIENTATION ([UIApplication sharedApplication].statusBarOrientation)

#define IS_PORTRAIT  UIInterfaceOrientationIsPortrait(DEVICE_ORIENTATION)
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape(DEVICE_ORIENTATION)

#define SCREEN_SCALE [UIScreen mainScreen].scale

#define points(pixels) (pixels / SCREEN_SCALE)
#define pixels(points) (points * SCREEN_SCALE)