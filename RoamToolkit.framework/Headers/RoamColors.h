//
//  RoamColors.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#define RGB(r, g, b)        RGBA(r, g, b, 1)
#define RGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define C_HEX_INT(hex)            [UIColor colorWithRGB:(hex)]
#define C_HEX_INT_ALPHA(hex, a)   [UIColor colorWithARGB:(hex) + (((NSUInteger) (a * 255.0)) << 24)]
#define C_HEX_STRING(hex)         [UIColor colorWithHexString:hex]

#define C_GRAY(shade)             [UIColor colorWithWhite:shade alpha:1]
#define C_GRAY_ALPHA(shade, a)    [UIColor colorWithWhite:shade alpha:a]

#define C_WHITE_ALPHA(a)    [C_WHITE colorWithAlphaComponent:a]
#define C_BLACK_ALPHA(a)    [C_BLACK colorWithAlphaComponent:a]

#define C_WHITE [UIColor whiteColor]
#define C_BLACK [UIColor blackColor]
#define C_CLEAR [UIColor clearColor]

#define C_MID_GRAY      [UIColor grayColor]
#define C_DARK_GRAY     [UIColor darkGrayColor]
#define C_LIGHT_GRAY    [UIColor lightGrayColor]

#define C_RED       [UIColor redColor]
#define C_GREEN     [UIColor greenColor]
#define C_BLUE      [UIColor blueColor]
#define C_CYAN      [UIColor cyanColor]
#define C_YELLOW    [UIColor yellowColor]
#define C_MAGENTA   [UIColor magentaColor]
#define C_ORANGE    [UIColor orangeColor]
#define C_PURPLE    [UIColor purpleColor]
#define C_BROWN     [UIColor brownColor]

#define C_RANDOM    RGB(arc4random() % 256, arc4random() % 256, arc4random() % 256)
