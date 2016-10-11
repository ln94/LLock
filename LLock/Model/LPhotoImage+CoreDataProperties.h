//
//  LPhotoImage+CoreDataProperties.h
//  LLock
//
//  Created by Lana Shatonova on 11/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoImage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LPhotoImage (CoreDataProperties)

+ (NSFetchRequest<LPhotoImage *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *fullImage;
@property (nullable, nonatomic, copy) NSNumber *photoId;
@property (nullable, nonatomic, retain) NSObject *thumbnail;

@end

NS_ASSUME_NONNULL_END
