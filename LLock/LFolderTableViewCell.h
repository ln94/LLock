//
//  LFolderTableViewCell.h
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFolderTableViewCellDelegate;

@interface LFolderTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *folderName;
@property (nonatomic) NSInteger photoCount;

@property (nonatomic) BOOL showDeleteButton;

@property (nonatomic) id<LFolderTableViewCellDelegate> delegate;

+ (NSString *)reuseIdentifier;
+ (CGFloat)rowHeight;

@end

@protocol LFolderTableViewCellDelegate <NSObject>

- (void)LFolderTableViewCell:(LFolderTableViewCell *)cell didSetShowDeleteButton:(BOOL)showing;

- (void)LFolderTableViewCell:(LFolderTableViewCell *)cell didPressDeleteButton:(UIButton *)button;

@end
