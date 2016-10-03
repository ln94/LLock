//
//  NSPredicate+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPredicate (Roam)

+ (NSPredicate *)predicateWithKey:(NSString *)key value:(id)value;
+ (NSPredicate *)predicateWithKeyValues:(NSDictionary *)pairs;

@end
