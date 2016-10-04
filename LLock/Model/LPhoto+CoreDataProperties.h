//
//  LPhoto+CoreDataProperties.h
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhoto+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LPhoto (CoreDataProperties)

+ (NSFetchRequest<LPhoto *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, retain) NSObject *image;
@property (nullable, nonatomic, retain) NSObject *location;
@property (nullable, nonatomic, retain) LFolder *folder;

@end

NS_ASSUME_NONNULL_END
