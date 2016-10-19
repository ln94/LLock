//
//  LPinViewController.h
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LPinViewControllerType) {
    LPinViewControllerTypeSetup,
    LPinViewControllerTypeConfirm,
    LPinViewControllerTypeEnter
};

@interface LPinViewController : UIViewController

- (instancetype)initWithType:(LPinViewControllerType)type;

@end
