//
//  UITableView+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Roam)

- (void)registerCellClass:(Class)cellClass;
- (void)registerHeaderFooterClass:(Class)headerFooterClass;
- (id)dequeueReusableCellWithClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath;
- (id)dequeueReusableHeaderFooterWithClass:(Class)headerFooterClass;

@end
