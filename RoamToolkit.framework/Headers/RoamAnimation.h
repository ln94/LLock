//
//  RoamAnimation.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Animation times

static const NSTimeInterval RMAnimationTimeNone    = 0.00;
static const NSTimeInterval RMAnimationTimeDefault = 0.30;
static const NSTimeInterval RMAnimationTimeShort   = 0.15;
static const NSTimeInterval RMAnimationTimeMedium  = 0.30;
static const NSTimeInterval RMAnimationTimeLong    = 0.60;


#pragma mark - Bounce

static const CGFloat RMAnimationBounceRatioNone    = 1.00;
static const CGFloat RMAnimationBounceRatioDefault = 0.60;
static const CGFloat RMAnimationBounceVelocityOut  = 0.00;
static const CGFloat RMAnimationBounceVelocityIn   = -15.0;


#pragma mark - Options

typedef NS_OPTIONS(NSUInteger, RMAnimationOptions) {
    RMAnimationOptionNone                      = 0,
    
    RMAnimationOptionLayoutSubviews            = UIViewAnimationOptionLayoutSubviews,
    RMAnimationOptionAllowUserInteraction      = UIViewAnimationOptionAllowUserInteraction,
    RMAnimationOptionBeginFromCurrentState     = UIViewAnimationOptionBeginFromCurrentState,
    RMAnimationOptionRepeat                    = UIViewAnimationOptionRepeat,
    RMAnimationOptionAutoreverse               = UIViewAnimationOptionAutoreverse,
    RMAnimationOptionOverrideInheritedDuration = UIViewAnimationOptionOverrideInheritedDuration,
    RMAnimationOptionOverrideInheritedCurve    = UIViewAnimationOptionOverrideInheritedCurve,
    RMAnimationOptionAllowAnimatedContent      = UIViewAnimationOptionAllowAnimatedContent,
    RMAnimationOptionShowHideTransitionViews   = UIViewAnimationOptionShowHideTransitionViews,
    RMAnimationOptionOverrideInheritedOptions  = UIViewAnimationOptionOverrideInheritedOptions,
    
    RMAnimationOptionCurveEaseInOut            = UIViewAnimationOptionCurveEaseInOut,
    RMAnimationOptionCurveEaseIn               = UIViewAnimationOptionCurveEaseIn,
    RMAnimationOptionCurveEaseOut              = UIViewAnimationOptionCurveEaseOut,
    RMAnimationOptionCurveLinear               = UIViewAnimationOptionCurveLinear,
    
    RMAnimationOptionTransitionNone            = UIViewAnimationOptionTransitionNone,
    RMAnimationOptionTransitionFlipFromLeft    = UIViewAnimationOptionTransitionFlipFromLeft,
    RMAnimationOptionTransitionFlipFromRight   = UIViewAnimationOptionTransitionFlipFromRight,
    RMAnimationOptionTransitionCurlUp          = UIViewAnimationOptionTransitionCurlUp,
    RMAnimationOptionTransitionCurlDown        = UIViewAnimationOptionTransitionCurlDown,
    RMAnimationOptionTransitionCrossDissolve   = UIViewAnimationOptionTransitionCrossDissolve,
    RMAnimationOptionTransitionFlipFromTop     = UIViewAnimationOptionTransitionFlipFromTop,
    RMAnimationOptionTransitionFlipFromBottom  = UIViewAnimationOptionTransitionFlipFromBottom,
    
    RMAnimationOptionCurveBounceOut            = 1 << 10,
    RMAnimationOptionCurveBounceIn             = 1 << 11,
    RMAnimationOptionCurveBounceInOut          = (RMAnimationOptionCurveBounceOut | RMAnimationOptionCurveBounceIn),
};

@interface RMAnimation : NSObject


#pragma mark - Class animations

+ (void)beginAnimations;
+ (void)commitAnimations;

+ (void)setAnimationDuration:(NSTimeInterval)duration;
+ (void)setAnimationDelay:(NSTimeInterval)delay;
+ (void)setAnimationStartDate:(NSDate *)startDate;
+ (void)setAnimationCurve:(UIViewAnimationCurve)curve;
+ (void)setAnimationRepeatCount:(float)repeatCount;
+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
+ (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;

+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(RMAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (void)animate:(void (^)(void))animations;
+ (void)animate:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)animateWithDuration:(NSTimeInterval)duration options:(RMAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)animateWithDuration:(NSTimeInterval)duration options:(RMAnimationOptions)options animations:(void (^)(void))animations;
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;


#pragma mark - Initialisers

+ (id)animationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(RMAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (id)animationWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
+ (id)animationWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (id)animationWithDuration:(NSTimeInterval)duration options:(RMAnimationOptions)options animations:(void (^)(void))animations;

#pragma mark - Run animations

+ (void)runAnimation:(RMAnimation *)animation;

+ (void)runAnimations:(NSArray *)animations;
+ (void)runAnimationsParallel:(NSArray *)animations;

+ (void)runAnimationsWithDurations:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;


@end
