//
//  LFolder+CoreDataProperties.m
//  LLock
//
//  Created by Lana Shatonova on 2/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import "LFolder+CoreDataProperties.h"

@implementation LFolder (CoreDataProperties)

+ (NSFetchRequest<LFolder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LFolder"];
}

@dynamic name;

@end
