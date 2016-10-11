//
//  LPhotoData+CoreDataProperties.h
//  LLock
//
//  Created by Lana Shatonova on 11/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhotoData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LPhotoData (CoreDataProperties)

+ (NSFetchRequest<LPhotoData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, copy) NSNumber *photoId;
@property (nullable, nonatomic, retain) NSObject *location;
@property (nullable, nonatomic, retain) LFolder *folder;

@end

NS_ASSUME_NONNULL_END
