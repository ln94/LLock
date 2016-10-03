//
//  NSString+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Roam)

@property (nonatomic, readonly, getter = isEmpty) BOOL empty;

- (BOOL)contains:(NSString *)substring;
- (BOOL)contains:(NSString *)substring options:(NSStringCompareOptions)options;

- (NSString *)trimmedString;
- (NSString *)noWhiteSpaceString;

- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByRemovingCharactersNotInSet:(NSCharacterSet *)characterSet;

@end
