//
//  LFolderTableViewCell.h
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFolderTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *folderName;
@property (nonatomic) NSInteger photoCount;

+ (NSString *)reuseIdentifier;
+ (CGFloat)rowHeight;

@end
