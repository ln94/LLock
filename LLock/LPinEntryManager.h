//
//  LPinEntryManager.h
//  LLock
//
//  Created by Lana Shatonova on 22/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PinEntryManager [LPinEntryManager singleton]

@interface LPinEntryManager : NSObject <Singleton>

@property (nonatomic) UIAlertController *alertControllerToReopen;

- (BOOL)willDisplayTouchIDAlert;
- (BOOL)isTouchIDAlertDisplayed;

- (void)validatePin;
- (void)validateTouchID;

- (void)handleSuccessfulPinEntry;

@end
