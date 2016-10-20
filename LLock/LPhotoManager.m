//
//  LPhotoManager.m
//  LLock
//
//  Created by Lana Shatonova on 11/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoManager.h"
#import <Photos/Photos.h>

@interface LPhotoManager ()

@end

@implementation LPhotoManager

- (void)savePhoto:(NSDictionary *)info inFolder:(LFolder *)folder {
    
    // Save photo image
    LPhotoImage *photoImage = [LPhotoImage create];
    photoImage.fullImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    photoImage.photoId = [self getAvailablePhotoId];
    
    // Save photo data
    LPhotoData *photoData = [LPhotoData create];
    photoData.folder = folder;
    photoData.photoId = photoImage.photoId;
    
    NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
    PHAsset *asset = [fetchResult firstObject];
    photoData.creationDate = asset.creationDate;
    photoData.location = asset.location;
    
    [DataStore save];
}

- (NSNumber *)getAvailablePhotoId {
    
    NSInteger photoId = 0;
    NSArray *photos = [LPhotoData allOrderedBy:@"photoId" ascending:YES];
    
    for (LPhotoData *photo in photos) {
        if ([photo.photoId integerValue] == photoId) {
            photoId++;
        }
        else {
            break;
        }
    }
    
    return [NSNumber numberWithInteger:photoId];
}

- (void)clearDB {
    
    for (LPhotoData *photo in [LPhotoData all]) {
        [photo destroy];
    }
    
    for (LPhotoImage *photo in [LPhotoImage all]) {
        [photo destroy];
    }
    
    [DataStore save];
}

@end
