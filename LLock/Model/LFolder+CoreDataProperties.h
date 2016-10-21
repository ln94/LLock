//
//  LFolder+CoreDataProperties.h
//  LLock
//
//  Created by Lana Shatonova on 21/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolder+CoreDataClass.h"
#import "LPhotoData+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFolder (CoreDataProperties)

+ (NSFetchRequest<LFolder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *index;
@property (nullable, nonatomic, retain) NSSet<LPhotoData *> *photos;

@end

@interface LFolder (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(LPhotoData *)value;
- (void)removePhotosObject:(LPhotoData *)value;
- (void)addPhotos:(NSSet<LPhotoData *> *)values;
- (void)removePhotos:(NSSet<LPhotoData *> *)values;

@end

NS_ASSUME_NONNULL_END
