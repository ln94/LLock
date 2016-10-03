//
//  NSDate+Roam.h
//
//  Copyright © Roam Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSTimeInterval SECONDS_IN_MINUTE;
extern const NSTimeInterval SECONDS_IN_HOUR;
extern const NSTimeInterval SECONDS_IN_DAY;
extern const NSTimeInterval SECONDS_IN_WEEK;
extern const NSTimeInterval MINUTES_IN_HOUR;
extern const NSTimeInterval HOURS_IN_DAY;
extern const NSTimeInterval DAYS_IN_WEEK;

@interface NSDate (Roam)

@property (nonatomic, readonly) NSInteger utcYear;
@property (nonatomic, readonly) NSInteger utcMonth;
@property (nonatomic, readonly) NSInteger utcDay;
@property (nonatomic, readonly) NSInteger utcHour;
@property (nonatomic, readonly) NSInteger utcMinute;
@property (nonatomic, readonly) NSInteger utcSecond;

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;

- (NSDate *)dateByAddingSeconds:(NSInteger)numSeconds;
- (NSDate *)dateByAddingMinutes:(NSInteger)numMinutes;
- (NSDate *)dateByAddingHours:(NSInteger)numHours;
- (NSDate *)dateByAddingDays:(NSInteger)numDays;
- (NSDate *)dateByAddingWeeks:(NSInteger)numWeeks;
- (NSDate *)dateByAddingMonths:(NSInteger)numMonths;
- (NSDate *)dateByAddingYears:(NSInteger)numYears;

- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle;
- (NSString *)formattedTimeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedDatePattern:(NSString *)datePattern;
- (NSString *)formattedDatePattern:(NSString *)datePattern timeZone:(NSTimeZone *)timeZone;

- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle;
- (NSString *)formattedUTCTimeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedUTCDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSString *)formattedUTCDatePattern:(NSString *)datePattern;

@property (nonatomic, readonly) NSDate *dateAsMidnight;
@property (nonatomic, readonly) NSString *timeAgoSinceNow;

@end
