//
//  NSObject+RoamNotifications.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RoamNotifications)

- (void)registerForNotification:(NSString *)name selector:(SEL)selector;
- (void)broadcastNotification:(NSString *)name;

- (void)unregisterAllNotifications;
- (void)unregisterNotification:(NSString *)name;

@end
