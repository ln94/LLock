//
//  LPhotoCollectionViewController.m
//  LLock
//
//  Created by Lana Shatonova on 3/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoCollectionViewController.h"
#import <Photos/Photos.h>

@interface LPhotoCollectionViewController () <UIImagePickerControllerDelegate>

@property (nonatomic, strong) LFolder *folder;

@property (nonatomic, strong) NSFetchedResultsController *photos;

@end


@implementation LPhotoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithFolder:(LFolder *)folder {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(50, 50)];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self = [super initWithCollectionViewLayout:layout];
    if (!self) return nil;
    
    self.folder = folder;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_CLEAR;
    
    // Navigation bar: title
    self.navigationItem.title = self.folder.name;
    
    // Navigation bar: back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    
    // Navigation bar: add photo button
    UIBarButtonItem *addPhotoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddPhotoButton)];
    addPhotoButton.tintColor = C_WHITE;
    self.navigationItem.rightBarButtonItem = addPhotoButton;
    
    // Collection view
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Frc
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
}

@end
