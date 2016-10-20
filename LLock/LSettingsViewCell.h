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

@protocol LSettingsViewCellDelegate;

@interface LSettingsViewCell : UITableViewCell

@property (nonatomic) LSettingsViewCellType type;

@property (nonatomic) id<LSettingsViewCellDelegate> delegate;

+ (NSString *)reuseIdentifier;
+ (CGFloat)rowHeight;

@end

@protocol LSettingsViewCellDelegate <NSObject>

- (void)settingsViewCell:(LSettingsViewCell *)cell didChangeSwitch:(BOOL)on;

@end
