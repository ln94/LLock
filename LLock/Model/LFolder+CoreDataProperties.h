//
//  LFolder+CoreDataProperties.h
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LFolder (CoreDataProperties)

+ (NSFetchRequest<LFolder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
