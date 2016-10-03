//
//  RoamSingleton.h
//
//  Copyright © Roam Creative. All rights reserved.
//
//
//  Recommended use:
//
//  SomeSingleton.h
//
//  @interface _SomeSingleton : NSObject <Singleton>
//
//  #define SomeSingleton [_SomeSingleton singleton]
//

#import <Foundation/Foundation.h>

@protocol Singleton <NSObject>

@optional
+ (instancetype)singleton;
- (void)setup;

@end
