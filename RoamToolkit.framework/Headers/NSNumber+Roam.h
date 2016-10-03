//
//  NSNumber+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Roam)

- (NSString *)formattedCurrency;
- (NSString *)formattedFlatCurrency;
- (NSString *)formattedCurrencyWithMinusSign;
- (NSString *)formattedDecimal;
- (NSString *)formattedFlatDecimal;
- (NSString *)formattedSpellOut;

@end
