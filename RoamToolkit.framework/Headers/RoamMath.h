//
//  RoamMath.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#define RANDOM_INT(count) arc4random_uniform(count)
#define RANDOM_INT_RANGE(min, max) (min + (arc4random() % ((max + 1) - min)))

#define RANDOM_0_1() ((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX)
#define RANDOM_MINUS1_1() (RANDOM_0_1() * 2.0f - 1.0f)

#define RADIANS(degrees) ((degrees * M_PI) / 180.0f)
#define DEGREES(radians) (radians * (180.0f/ M_PI ))

#define RANDOM_BOOL(probability) (RANDOM_0_1() < probability)
