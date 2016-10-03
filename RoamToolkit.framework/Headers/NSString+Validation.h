//
//  NSString+Validation.h
//  RoamToolkit
//
//  Created by Jarrad Edwards on 15/05/14.
//  Copyright (c) 2014 Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

@property (nonatomic, readonly, getter = isValidEmailAddress) BOOL validEmailAddress;
@property (nonatomic, readonly, getter = isValidPhoneNumber) BOOL validPhoneNumber;
@property (nonatomic, readonly, getter = isAlphaNumeric) BOOL alphaNumeric;
@property (nonatomic, readonly, getter = isAlpha) BOOL alpha;
@property (nonatomic, readonly, getter = isNumeric) BOOL numeric;

@end
