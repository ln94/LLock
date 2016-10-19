//
//  LSettingsViewCell.h
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LSettingsViewCellType) {
    LSettingsViewCellTypePIN,
    LSettingsViewCellTypeTouchID
};

@interface LSettingsViewCell : UITableViewCell

@property (nonatomic) LSettingsViewCellType type;

+ (NSString *)reuseIdentifier;
+ (CGFloat)rowHeight;

@end
