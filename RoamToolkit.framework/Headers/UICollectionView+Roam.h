//
//  UICollectionView+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Roam)

- (void)registerCellClass:(Class)cellClass;
- (id)dequeueReusableCellWithClass:(Class)cellClass indexPath:(NSIndexPath *)indexPath;

@end
