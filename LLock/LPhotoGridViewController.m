//
//  LPhotoGridViewController.m
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoGridViewController.h"
#import <Photos/Photos.h>
#import "LPhotoGridViewCell.h"
#import "LPhotoManager.h"
#import "LPhotoDetailViewController.h"

@interface LPhotoGridViewController () <NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) LFolder *folder;
@property (nonatomic, strong) NSFetchedResultsController *photos;

@end


@implementation LPhotoGridViewController

- (instancetype)initWithFolder:(LFolder *)folder {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size_square([LPhotoGridViewCell cellWidth]);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self = [super initWithCollectionViewLayout:layout];
    if (!self) return nil;
    
    self.folder = folder;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_CLEAR;
    
    // Navigation bar: title
    self.navigationItem.title = [self.folder.name uppercaseString];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Navigation bar: add photo button
    UIBarButtonItem *addPhotoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddPhotoButton)];
    addPhotoButton.tintColor = C_WHITE;
    self.navigationItem.rightBarButtonItem = addPhotoButton;
    
    // Collection view
    [self.collectionView registerClass:[LPhotoGridViewCell class] forCellWithReuseIdentifier:[LPhotoGridViewCell reuseIdentifier]];
    self.collectionView.contentInset = i(1, 0, 20, 0);
    self.collectionView.alwaysBounceVertical = YES;
    
    // Frc
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[LPhotoData class] predicate:[NSPredicate predicateWithKey:@"folder" value:self.folder]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES];
    self.photos = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:DataContext sectionNameKeyPath:nil cacheName:nil];
    [self.photos performFetch];
    self.photos.delegate = self;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.numberOfObjects;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LPhotoGridViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LPhotoGridViewCell reuseIdentifier] forIndexPath:indexPath];

    LPhotoData *photo = [self.photos objectAtIndexPath:indexPath];
    cell.photoId = photo.photoId;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Open photo detail view controller
    LPhotoDetailViewController *photoVC = [[LPhotoDetailViewController alloc] initWithSize:self.view.size fetchedResultsController:self.photos andSelectedIndexPath:indexPath];
    [self.navigationController pushViewController:photoVC animated:YES];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
}


#pragma mark - Add photo

- (void)didPressAddPhotoButton {
    
    [self checkPhotoGalleryPermission:^{
        // Open image picker controller
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
}

- (void)checkPhotoGalleryPermission:(void (^)(void))permissionGrantedBlock {
    
    // Check permissions
    switch ([PHPhotoLibrary authorizationStatus])
    {
        case PHAuthorizationStatusAuthorized: {
            if (permissionGrantedBlock) permissionGrantedBlock();
        }
            break;
            
        case PHAuthorizationStatusDenied:
        {
            // Show not authorized message
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Photo Access Denied" message:@"Please grant access to your photos from Settings" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
            
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized && permissionGrantedBlock) {
                    permissionGrantedBlock();
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Save photo
    [PhotoManager savePhoto:info inFolder:self.folder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
