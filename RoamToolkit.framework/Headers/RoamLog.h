//
//  RoamLog.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#define LOGERR(error)       NSLog(@"[ERROR] %@", error)

#define LOGINFO(A, ...)     NSLog(@"INFO: %@", [NSString stringWithFormat:A, ## __VA_ARGS__])

#define LOG(A, ...)         NSLog(@"%@", [NSString stringWithFormat:A, ## __VA_ARGS__])

#define LOGDBG(A, ...)      NSLog(@"DEBUG: %s:%d:%@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:A, ## __VA_ARGS__])

#define LOGSTAR(A, ...)     NSLog(@"\n_________________________________________________________________\n\n%@\n\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣",[NSString stringWithFormat:A, ## __VA_ARGS__])


#define NSStringFromCGInsets(insets) NSStringFromUIEdgeInsets(insets)
#define NSStringFromBOOL(bool) (bool ? @"YES" : @"NO")