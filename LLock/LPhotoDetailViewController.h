//
//  LPhotoDetailViewController.h
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPhotoDetailViewController : UICollectionViewController

- (instancetype)initWithSize:(CGSize)size fetchedResultsController:(NSFetchedResultsController *)photos andSelectedIndexPath:(NSIndexPath *)indexPath;

@end
