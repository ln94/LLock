//
//  LPhotoManager.h
//  LLock
//
//  Created by Lana Shatonova on 11/10/16.
//  Copyright © 2016 Lana Shatonova. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PhotoManager [LPhotoManager singleton]

@interface LPhotoManager : NSObject <Singleton>

- (void)savePhoto:(NSDictionary *)info inFolder:(LFolder *)folder;

@end
