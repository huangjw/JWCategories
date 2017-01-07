//
//  NSDate+JWExtensions.h
//  JWCategories
//
//  Created by huangjw on 2017/1/7.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JWExtensions)

/**
 获取日、月、年、小时、分钟、秒

 @return
 */
- (NSUInteger)jw_day;
- (NSUInteger)jw_month;
- (NSUInteger)jw_year;
- (NSUInteger)jw_hour;
- (NSUInteger)jw_minute;
- (NSUInteger)jw_second;
+ (NSUInteger)jw_day:(NSDate *)date;
+ (NSUInteger)jw_month:(NSDate *)date;
+ (NSUInteger)jw_year:(NSDate *)date;
+ (NSUInteger)jw_hour:(NSDate *)date;
+ (NSUInteger)jw_minute:(NSDate *)date;
+ (NSUInteger)jw_second:(NSDate *)date;

/**
 日期格式化

 @return 
 */
- (NSString *)jw_stringWithFormat:(NSString *)format;
- (NSString *)jw_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSString *)jw_shortString;
- (NSString *)jw_shortDateString;
- (NSString *)jw_shortTimeString;
- (NSString *)jw_mediumString;
- (NSString *)jw_mediumDateString;
- (NSString *)jw_mediumTimeString;
- (NSString *)jw_longString;
- (NSString *)jw_longDateString;
- (NSString *)jw_longTimeString;

@end
