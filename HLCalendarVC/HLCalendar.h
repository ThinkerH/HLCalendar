//
//  HLCalendar.h
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLCalendar : NSObject

+ (instancetype)shareInstance;

// 获取date的下个月日期
- (NSDate *)nextMonthDateByDate:(NSDate *)date;

// 获取date的上个月日期
- (NSDate *)previousMonthDateByDate:(NSDate *)date;

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate:(NSDate *)date;

- (NSInteger)weekdayOfDate:(NSDate *)date;

- (NSString *)weekDayStrOfDate:(NSDate *)date;

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date;

// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date;

- (NSMutableArray *)monthsWithDate:(NSDate *)date monthes:(NSInteger)monthes;

- (NSDate *)dateWithDateStr:(NSString *)dateStr format:(NSString *)format;

- (NSDate *)dateStrWithDate:(NSDate *)date format:(NSString *)format;

/**
 获取指定日期的日历数据
 
 @param monthes 获取的月的个数
 @param fromDate 从该日期开始获取
 @return 日历数据
 */
- (NSMutableDictionary *)calendarDataWithMonthes:(NSInteger)monthes fromDate:(NSDate *)fromDate;


@end
