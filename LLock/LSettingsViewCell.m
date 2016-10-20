//
//  LSettingsViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 19/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LSettingsViewCell.h"

static NSString *const reuseIdentifier = @"settingsTableCell";

static const CGFloat kCellRowHeight = 70;

@interface LSettingsViewCell()

@property (nonatomic) UILabel *label;

@property (nonatomic, strong) UISwitch *switchControl;

@end

@implementation LSettingsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Text Label
    self.label = [[UILabel alloc] initFullInSuperview:self.contentView insets:inset_left(20)];
    self.label.backgroundColor = C_CLEAR;
    self.label.textColor = C_MAIN;
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.textAlignment = NSTextAlignmentLeft;
    
    // Switch
    self.switchControl = [[UISwitch alloc] initInSuperview:self.contentView edge:UIViewEdgeRight length:25 insets:i(20, 40, 20, 0)];
    [self.switchControl addTarget:self action:@selector(didChangeSwitchControl) forControlEvents:UIControlEventValueChanged];
    
    return self;
}

#pragma mark - Getters

+(NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeight {
    return kCellRowHeight;
}

#pragma mark - Setters

-(void)setType:(LSettingsViewCellType)type {
    _type = type;
    
    if (type == LSettingsViewCellTypePIN) {
        self.label.text = @"Passcode";
        [self.switchControl setOn:SettingsManager.pinEnabled animated:YES];
    }
    else {
        self.label.text = @"Touch ID";
        [self.switchControl setOn:SettingsManager.touchIDEnabled animated:YES];
    }
}

- (void)didChangeSwitchControl {
    
    if (self.delegate) {
        [self.delegate settingsViewCell:self didChangeSwitch:self.switchControl.on];
    }
}

@end
