//
//  LPhotoDetailViewController.m
//  LLock
//
//  Created by Lana Shatonova on 13/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoDetailViewController.h"
#import "LPhotoDetailViewCell.h"

static const CGFloat spacing = 15;

@interface LPhotoDetailViewController ()

@property (nonatomic, strong) NSFetchedResultsController *photos;
@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *timeLabel;

@end

@implementation LPhotoDetailViewController

- (instancetype)initWithSize:(CGSize)size fetchedResultsController:(NSFetchedResultsController *)photos andSelectedIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size;
    layout.minimumLineSpacing = spacing;
    layout.minimumInteritemSpacing = spacing;
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
    UIView *titleView = [[UIView alloc] initWithSize:self.navigationController.navigationBar.size];
    
    self.dateLabel = [[UILabel alloc] initInSuperview:titleView edge:UIViewEdgeTop length:20 insets:i(3, 0, 0, -44)];
    self.dateLabel.textColor = C_WHITE;
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    
    self.timeLabel = [[UILabel alloc] initInSuperview:titleView edge:UIViewEdgeTop length:15 insets:i(0, 0, 0, -44)];
    self.timeLabel.top = self.dateLabel.bottom;
    self.timeLabel.textColor = C_WHITE;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = titleView;
    
    LPhotoData *photoInfo = [self.photos objectAtIndexPath:self.selectedIndexPath];
    [self updateTitleWithDate:photoInfo.creationDate];
    
    // Register cell classes
    [self.collectionView registerClass:[LPhotoDetailViewCell class] forCellWithReuseIdentifier:[LPhotoDetailViewCell reuseIdentifier]];
    self.collectionView.alwaysBounceHorizontal = YES;
    
    [self.collectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)updateTitleWithDate:(NSDate *)date {
    
    // Set date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if ([NSDate date].year == date.year) {
        [dateFormatter setDateFormat:@"d MMMM, EEEE"];
    }
    else {
        [dateFormatter setDateFormat:@"d MMMM yyyy, EEEE"];
    }
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    //Set time
    [dateFormatter setDateFormat:@"h:mm a"];
    self.timeLabel.text = [dateFormatter stringFromDate:date];
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

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // Correct scrolling
    CGFloat pageWidth = scrollView.width + spacing;
    
    CGFloat currentOffset = scrollView.contentOffset.x;
    CGFloat targetOffset = targetContentOffset->x;
    
    CGFloat newTargetOffset = targetOffset > currentOffset ? ceilf(currentOffset / pageWidth) * pageWidth : floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0) {
        newTargetOffset = 0;
    }
    else if (newTargetOffset > scrollView.contentSize.width) {
        newTargetOffset = scrollView.contentSize.width;
    }
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:p(newTargetOffset, scrollView.contentOffset.y) animated:YES];
    
    // Title updating
    NSInteger index = newTargetOffset / pageWidth;
    LPhotoData *photoInfo = [self.photos objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [self updateTitleWithDate:photoInfo.creationDate];
}

@end
