//
//  LSettingsManager.m
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LSettingsManager.h"

#define Defaults [NSUserDefaults standardUserDefaults]

// Keys
static NSString *const L_PIN_ENABLED_KEY = @"L_PIN_ENABLED";
static NSString *const L_PIN_KEY = @"L_PIN_KEY";
static NSString *const L_TOUCH_ID_ENABLED_KEY = @"L_TOUCH_ID_ENABLED";

@implementation LSettingsManager

- (void)setup {
    
    NSDictionary *defaultPreferences = @{
                                         L_PIN_ENABLED_KEY: @(NO),
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

@end
