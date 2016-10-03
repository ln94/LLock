//
//  NSMutableAttributedString+Roam.h
//  RoamToolkit
//
//  Created by Stuart Austin on 30/09/15.
//  Copyright © 2015 RoamLtd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSAttributedString+Roam.h"

@interface NSMutableAttributedString (Roam)

- (void)appendString:(NSString *)string;
- (void)appendString:(NSString *)string attributes:(NSDictionary *)attributes;
- (void)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)appendFormatWithAttributes:(NSDictionary *) attributes format: (NSString *) format, ... NS_FORMAT_FUNCTION(2,3);

@end
