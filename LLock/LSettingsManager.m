//
//  LSettingsManager.m
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LSettingsManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define Defaults [NSUserDefaults standardUserDefaults]

// Keys
static NSString *const L_PIN_ENABLED_KEY = @"L_PIN_ENABLED";
static NSString *const L_PIN_KEY = @"L_PIN_KEY";
static NSString *const L_TOUCH_ID_ENABLED_KEY = @"L_TOUCH_ID_ENABLED";

static NSString *touchIDReason = @"Touch to get access";

@implementation LSettingsManager

- (void)setup {
    
    NSDictionary *defaultPreferences = @{
                                         L_PIN_ENABLED_KEY: @(NO),
                                         L_PIN_KEY: @(-1),
                                         L_TOUCH_ID_ENABLED_KEY: @(NO)
                                         };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPreferences];
}

- (void)save {
    [Defaults synchronize];
}

#pragma mark - PIN

- (void)setPinEnabled:(BOOL)pinEnabled {
    [Defaults setBool:pinEnabled forKey:L_PIN_ENABLED_KEY];
    [self save];
}

- (BOOL)pinEnabled {
    return [Defaults boolForKey:L_PIN_ENABLED_KEY];
}

- (void)setPin:(NSInteger)pin {
    [Defaults setInteger:pin forKey:L_PIN_KEY];
    [self save];
}

-(NSInteger)pin {
    return [Defaults integerForKey:L_PIN_KEY];
}

#pragma mark - TouchID

- (void)setTouchIDEnabled:(BOOL)touchIDEnabled {
    [Defaults setBool:touchIDEnabled forKey:L_TOUCH_ID_ENABLED_KEY];
    [self save];
}

- (BOOL)touchIDEnabled {
    return [Defaults boolForKey:L_TOUCH_ID_ENABLED_KEY];
}

- (BOOL)touchIDAvailable {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
}

- (void)askForTouchID:(void(^)(BOOL success, NSError *error))reply {
    LAContext *context = [[LAContext alloc] init];
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:touchIDReason reply:^(BOOL success, NSError * _Nullable error) {
        reply(success, error);
    }];
}


@end
