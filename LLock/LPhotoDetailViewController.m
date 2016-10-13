//
//  LPhotoDetailViewController.m
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoDetailViewController.h"
#import "LPhotoDetailViewCell.h"

@interface LPhotoDetailViewController ()

@property (nonatomic, strong) NSFetchedResultsController *photos;
@property (nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation LPhotoDetailViewController

- (instancetype)initWithSize:(CGSize)size fetchedResultsController:(NSFetchedResultsController *)photos andSelectedIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithCollectionViewLayout:layout];
    if (!self) return nil;
    
    self.photos = photos;
    self.selectedIndexPath = indexPath;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_CLEAR;
    
    // Navigation bar: title
    self.navigationItem.title = string(@"%ld of %ld", self.selectedIndexPath.row + 1, self.photos.numberOfObjects);
    
    // Register cell classes
    [self.collectionView registerClass:[LPhotoDetailViewCell class] forCellWithReuseIdentifier:[LPhotoDetailViewCell reuseIdentifier]];
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.decelerationRate = -1;
    
    [self.collectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.numberOfObjects;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LPhotoDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LPhotoDetailViewCell reuseIdentifier] forIndexPath:indexPath];
    
    LPhotoData *photo = [self.photos objectAtIndexPath:indexPath];
    cell.photoId = photo.photoId;
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.isDragging) {
        LOG(@"Dragging");
    }
    else {
        [self normilizeScrollView:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        [self normilizeScrollView:scrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    scrollView.decelerationRate = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self normilizeScrollView:scrollView];
}

- (void)normilizeScrollView:(UIScrollView *)scrollView {
    
    int index = (int)scrollView.contentOffset.x / (int)scrollView.width;
    int absoluteOffsetX = (int)scrollView.contentOffset.x % (int)scrollView.width;
    LOG(@"%i", absoluteOffsetX);
    
    if (absoluteOffsetX < 100) {
        // Stay on the same potato
    }
    else {
        index++;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        scrollView.contentOffset = p(index * scrollView.width, scrollView.contentOffset.y);
    }];
}

@end
