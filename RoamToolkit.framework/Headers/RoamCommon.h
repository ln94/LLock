//
//  RoamCommon.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#define string(format, ...) [NSString stringWithFormat:format, ## __VA_ARGS__]
#define image(name)         [UIImage imageNamed:name]
#define url(string)         [NSURL URLWithString:string]

#define count(var, amount) for (int var = 0; var < amount; var++)

#define sel(_selector_) NSStringFromSelector(@selector(_selector_))