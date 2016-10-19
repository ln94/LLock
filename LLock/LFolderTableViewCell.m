//
//  LFolderTableViewCell.m
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolderTableViewCell.h"

static NSString *const reuseIdentifier = @"folderTableCell";

static const CGFloat kCellRowHeight = 55;
static const CGFloat kDeleteButtonWidth = 110;

@interface LFolderTableViewCell()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UILabel *folderNameLabel;
@property (nonatomic, strong) UILabel *photoCountLabel;

@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation LFolderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Cell View
    self.cellView = [[UIView alloc] initFullInSuperview:self];
    self.cellView.backgroundColor = C_CLEAR;
    
    self.folderNameLabel = [[UILabel alloc] initFullInSuperview:self.cellView insets:i(0, 50, 0, 20)];
    self.folderNameLabel.backgroundColor = C_CLEAR;
    self.folderNameLabel.textColor = C_MAIN_WHITE;
    self.folderNameLabel.font = [UIFont systemFontOfSize:16];
    self.folderNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.photoCountLabel = [[UILabel alloc] initInSuperview:self.cellView edge:UIViewEdgeRight length:35 insets:inset_right(18)];
    self.photoCountLabel.backgroundColor = C_CLEAR;
    self.photoCountLabel.textColor = C_LIGHT_GRAY;
    self.photoCountLabel.font = [UIFont systemFontOfSize:14];
    self.photoCountLabel.textAlignment = NSTextAlignmentRight;
    
    // Delete Button
    self.deleteButton = [[UIButton alloc] initInSuperview:self edge:UIViewEdgeRight length:kDeleteButtonWidth insets:inset_right(-kDeleteButtonWidth)];
    self.deleteButton.backgroundColor = C_RED;
    self.deleteButton.text = @"Delete";
    [self.deleteButton addTarget:self action:@selector(didPressDeleteFolderButton:)];
    
    // Swipe gestures
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.backgroundColor = selected ? C_GRAY(0.1) : C_CLEAR;
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
    _folderName = folderName;
    self.folderNameLabel.text = folderName;
}

- (void)setPhotoCount:(NSInteger)photoCount {
    _photoCount = photoCount;
    self.photoCountLabel.text = string(@"%ld", photoCount);
}

- (void)setShowDeleteButton:(BOOL)showDeleteButton {
    
    if (showDeleteButton && self.cellView.x == 0) {
        
        [self.delegate LFolderTableViewCell:self didSetShowDeleteButton:showDeleteButton];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.cellView.x-= kDeleteButtonWidth;
            self.deleteButton.x -= kDeleteButtonWidth;
        }];
    }
    else if (!showDeleteButton && self.cellView.x != 0) {
        
        [self.delegate LFolderTableViewCell:self didSetShowDeleteButton:showDeleteButton];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.cellView.x = 0;
            self.deleteButton.x = self.width;
        }];
    }
}

#pragma mark - Swipes

- (void)swipeLeft {
    self.showDeleteButton = YES;
}

- (void)swipeRight {
    self.showDeleteButton = NO;
}

#pragma mark - Delete Folder

- (void)didPressDeleteFolderButton:(UIButton *)button {
    
    [self.delegate LFolderTableViewCell:self didPressDeleteButton:button];
}

@end
