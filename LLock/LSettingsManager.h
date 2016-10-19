//
//  LSettingsManager.h
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SettingsManager [LSettingsManager singleton]

@interface LSettingsManager : NSObject <Singleton>

@property (nonatomic) BOOL pinEnabled;
@property (nonatomic) NSInteger pin;
@property (nonatomic) BOOL touchIDEnabled;

@end
