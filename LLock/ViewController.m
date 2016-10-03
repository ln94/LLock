//
//  ViewController.m
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "ViewController.h"
#import "LFolderTableViewCell.h"
#import "LPhotoCollectionViewController.h"
#import <Photos/Photos.h>

@interface ViewController () <UITextFieldDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *folders;
@property (nonatomic, strong) UIAlertController *alertController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_CLEAR;
    
    // Navigation bar: add photo button
    UIBarButtonItem *addPhotoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didPressAddPhotoButton)];
    addPhotoButton.tintColor = C_WHITE;
    self.navigationItem.leftBarButtonItem = addPhotoButton;
    
    // Table view
    self.tableView.backgroundColor = C_CLEAR;
    self.tableView.separatorColor = C_DARK_GRAY;
    [self.tableView registerClass:[LFolderTableViewCell class] forCellReuseIdentifier:[LFolderTableViewCell reuseIdentifier]];
    self.tableView.rowHeight = [LFolderTableViewCell rowHeight];
    
    // Table view footer: add folder button
    UIView *footer = [[UIView alloc] initWithSize:s(self.tableView.width, self.tableView.rowHeight + 10)];
    footer.backgroundColor = C_CLEAR;
    
    UIButton *addFolderButton = [[UIButton alloc] initInSuperview:footer corner:UIViewCornerTopLeft size:s(20,20) insets:i(10, 0, 0, 18)];
    addFolderButton.backgroundColor = C_CLEAR;
    NSAttributedString *addFolderTitle = [NSAttributedString attributedStringWithString:@"+" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26], NSForegroundColorAttributeName:C_WHITE}];
    [addFolderButton setAttributedTitle:addFolderTitle forState:UIControlStateNormal];
    [addFolderButton addTarget:self action:@selector(didPressAddFolderButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footer;
    
    // Add folder alert controller
    self.alertController = [UIAlertController alertControllerWithTitle:@"New Folder" message:@"Enter a name for this folder." preferredStyle:UIAlertControllerStyleAlert];
    
    [self.alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        textField.placeholder = @"Name";
    }];
    self.alertController.textFields[0].delegate = self;
    
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Save the folder
        LFolder *newFolder = [LFolder createInContext:DataContext];
        newFolder.name = self.alertController.textFields[0].text;
        [DataStore save];
        self.alertController.textFields[0].text = nil;
    }];
    saveAction.enabled = NO;
    [self.alertController addAction:saveAction];
    
    // Frc
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[LFolder class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    self.folders = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:DataContext sectionNameKeyPath:nil cacheName:nil];
    [self.folders performFetch];
    self.folders.delegate = self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.folders.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFolderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[LFolderTableViewCell reuseIdentifier]];
    cell.folderName = ((LFolder *)[self.folders objectAtIndexPath:indexPath]).name;
    cell.photoCount = 155;
    
    return cell;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)didPressAddFolderButton {
    // Show alert controller
    [self presentViewController:self.alertController animated:YES completion:nil];
}

- (void)didPressAddPhotoButton {
    
    [self checkPhotoGalleryPermission:^{
        // Open image picker controller
        
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

#pragma  mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    self.alertController.actions[1].enabled = ![textField.text stringByReplacingCharactersInRange:range withString:string].isEmpty;
    
    return YES;
}

@end
