//
//  LPhoto+CoreDataProperties.m
//  LLock
//
//  Created by Lana Shatonova on 4/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LPhoto+CoreDataProperties.h"

@implementation LPhoto (CoreDataProperties)

+ (NSFetchRequest<LPhoto *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LPhoto"];
}

@dynamic creationDate;
@dynamic image;
@dynamic location;
@dynamic folder;

@end
