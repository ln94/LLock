//
//  LFolderTableViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolderTableViewCell.h"

static NSString *const reuseIdentifier = @"folderTableCell";

static const CGFloat kCellRowHeight = 50;

@interface LFolderTableViewCell()

@property (nonatomic, strong) UILabel *folderNameLabel;
@property (nonatomic, strong) UILabel *photoCountLabel;

@end

@implementation LFolderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    
    self.folderNameLabel = [[UILabel alloc] initFullInSuperview:self insets:i(0, 50, 0, 20)];
    self.folderNameLabel.backgroundColor = C_CLEAR;
    self.folderNameLabel.textColor = C_WHITE;
    self.folderNameLabel.font = [UIFont systemFontOfSize:17];
    self.folderNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.photoCountLabel = [[UILabel alloc] initInSuperview:self edge:UIViewEdgeRight length:35 insets:inset_right(10)];
    self.photoCountLabel.backgroundColor = C_CLEAR;
    self.photoCountLabel.textColor = C_LIGHT_GRAY;
    self.photoCountLabel.font = [UIFont systemFontOfSize:14];
    self.photoCountLabel.textAlignment = NSTextAlignmentRight;
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Getters

+(NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeight {
    return kCellRowHeight;
}

#pragma mark - Setters

- (void)setFolderName:(NSString *)folderName {
    self.folderNameLabel.text = folderName;
}

- (void)setPhotoCount:(NSInteger)photoCount {
    self.photoCountLabel.text = string(@"%ld", photoCount);
}

@end
