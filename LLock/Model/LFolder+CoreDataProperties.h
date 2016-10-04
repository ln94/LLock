//
//  LFolder+CoreDataProperties.h
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LFolder (CoreDataProperties)

+ (NSFetchRequest<LFolder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<LPhoto *> *photos;

@end

@interface LFolder (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(LPhoto *)value;
- (void)removePhotosObject:(LPhoto *)value;
- (void)addPhotos:(NSSet<LPhoto *> *)values;
- (void)removePhotos:(NSSet<LPhoto *> *)values;

@end

NS_ASSUME_NONNULL_END
