//
//  LPinEntryManager.m
//  LLock
//
//  Created by Lana Shatonova on 22/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPinEntryManager.h"
#import "LPinViewController.h"

@implementation LPinEntryManager {
    BOOL isTouchIDAlertDisplayed;
}

- (void)setup {
    isTouchIDAlertDisplayed = NO;
}

#pragma mark - TouchID Alert

- (BOOL)willDisplayTouchIDAlert {
    return SettingsManager.touchIDEnabled && SettingsManager.touchIDAvailable;
}

- (BOOL)isTouchIDAlertDisplayed {
    return isTouchIDAlertDisplayed;
}

#pragma mark - Validation

- (void)validatePin {
    // If pin is enabled, open Pin entry screen
    if (SettingsManager.pinEnabled) {
        
        UIViewController *topVC = [LLock topViewController];
        
        if ([topVC isKindOfClass:[LPinViewController class]] && [(LPinViewController *)topVC isEnterType]) {
            // If Pin entry screen is already presented, check Touch ID
            [self validateTouchIDFromPinViewController:(LPinViewController *)topVC];
        }
        else {
            // Present Pin entry screen
            LPinViewController *pinVC = [[LPinViewController alloc] initWithType:LPinViewControllerTypeEnter];
            [topVC presentViewController:pinVC animated:NO completion:^{
                [self validateTouchIDFromPinViewController:pinVC];
            }];
        }
    }
}

- (void)validateTouchIDFromPinViewController:(LPinViewController *)pinVC {
    // If Touch ID is enabled, display Touch ID alert
    if ([self willDisplayTouchIDAlert]) {
        
        isTouchIDAlertDisplayed = YES;
        [SettingsManager askForTouchID:^(BOOL success, NSError *error) {
            run_main(^{
                
                isTouchIDAlertDisplayed = NO;
                if (success) {
                    [self handleSuccessfulPinEntry];
                }
            });
        }];
    }
    else {
        // If Touch ID alert can't be opened, show keyboard for Pin entry screen
        isTouchIDAlertDisplayed = NO;
        [pinVC showKeyboard];
    }
}

- (void)handleSuccessfulPinEntry {
    
    // Dismiss Pin entry screen with dissolve animation
    UIViewController *topVC = [LLock topViewController];
    [UIView transitionFromView:topVC.view toView:topVC.presentingViewController.view duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        
        [topVC.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
            // Reopen alert controller if it was closed before
            if (self.alertControllerToReopen) {
                [[LLock topViewController] presentViewController:self.alertControllerToReopen animated:YES completion:^{
                    self.alertControllerToReopen = nil;
                }];
            }
        }];
    }];
    
}


@end










