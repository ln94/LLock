//
//  LPhotoCollectionViewController.m
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoCollectionViewController.h"
#import <Photos/Photos.h>
#import "LPhotoGridCollectionViewCell.h"

@interface LPhotoCollectionViewController () <NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) LFolder *folder;
@property (nonatomic, strong) NSFetchedResultsController *photos;

@end


@implementation LPhotoCollectionViewController

- (instancetype)initWithFolder:(LFolder *)folder {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size_square([LPhotoGridCollectionViewCell cellWidth]);
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
    
    // Navigation bar: add photo button
    UIBarButtonItem *addPhotoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddPhotoButton)];
    addPhotoButton.tintColor = C_WHITE;
    self.navigationItem.rightBarButtonItem = addPhotoButton;
    
    // Collection view
    [self.collectionView registerClass:[LPhotoGridCollectionViewCell class] forCellWithReuseIdentifier:[LPhotoGridCollectionViewCell reuseIdentifier]];
    self.collectionView.contentInset = inset_bottom(20);
    
    // Frc
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[LPhoto class] predicate:[NSPredicate predicateWithKey:@"folder" value:self.folder]];
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
    LPhotoGridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LPhotoGridCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.backgroundColor = C_RANDOM;
//    LPhoto *photo = [self.photos objectAtIndexPath:indexPath];
//    UIImage *image = (UIImage *)photo.image;
//    
//    UIImageView *imageView = [[UIImageView alloc] initFullInSuperview:cell];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.clipsToBounds = YES;
//    imageView.image = image;
//    
//    cell.image = image;
    
    return cell;
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
    LPhoto *photo = [LPhoto create];
    photo.folder = self.folder;
    photo.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
    PHAsset *asset = [fetchResult firstObject];
    photo.creationDate = asset.creationDate;
    photo.location = asset.location;
    
    [DataStore save];
}

@end
