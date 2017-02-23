//
//  HLCalendar.m
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "HLCalendar.h"

#define WeekDays @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]
#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

typedef NS_ENUM(NSUInteger, FDCalendarMonth) {
    FDCalendarMonthPrevious = 0,
    FDCalendarMonthCurrent = 1,
    FDCalendarMonthNext = 2,
};
static int monthesC;
static NSMutableArray *monthesArr;
static NSMutableDictionary *dateSource;

@interface HLCalendar ()
//@property (strong, nonatomic) NSDate *date;
@end

@implementation HLCalendar

+ (instancetype)shareInstance {
    static HLCalendar *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shareInstance = [[HLCalendar alloc] init];
        monthesC = 0;
        monthesArr = [NSMutableArray array];
        dateSource = [NSMutableDictionary dictionary];
    });
    return  shareInstance;
}

#pragma mark - Public

// 获取date的下个月日期
- (NSDate *)nextMonthDateByDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

// 获取date的上个月日期
- (NSDate *)previousMonthDateByDate:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

- (NSInteger)weekdayOfDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *weekComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return weekComponents.weekday - 1;
}

- (NSString *)weekDayStrOfDate:(NSDate *)date {
    return WeekDays[[self weekdayOfDate:date]];
}

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

//// 获取某月day的日期
//+ (NSDate *)dateOfMonth:(FDCalendarMonth)calendarMonth WithDay:(NSInteger)day {
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *date;
//    
//    switch (calendarMonth) {
//        case FDCalendarMonthPrevious:
//            date = [self previousMonthDate];
//            break;
//            
//        case FDCalendarMonthCurrent:
//            date = self.date;
//            break;
//            
//        case FDCalendarMonthNext:
//            date = [self nextMonthDate];
//            break;
//        default:
//            break;
//    }
//    
//    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
//    [components setDay:day];
//    NSDate *dateOfDay = [calendar dateFromComponents:components];
//    return dateOfDay;
//}

// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    NSString *day;
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    if (components.day == 1) {
        day = ChineseMonths[components.month - 1];
    } else {
        day = ChineseDays[components.day - 1];
    }
    
    return day;
}

- (NSMutableArray *)monthsWithDate:(NSDate *)date monthes:(NSInteger)monthes {
    
    if (monthesC == monthes && monthesArr.count == monthes) {
        return monthesArr;
    }
    
    monthesC = monthes;
    
    NSMutableArray *months = [NSMutableArray array];
    
    NSCalendar * calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    for (int i = 0; i < 12; i++) {
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
        
        [comps setYear:0];
        [comps setMonth:i];
        NSDate *newdate = [calendar dateByAddingComponents:comps toDate:date options:0];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy年MM月";
        
        NSString *str = [NSString stringWithFormat:@"%@",[formatter stringFromDate:newdate]];
        
        [months addObject:str];
    }
    
    monthesArr = [months mutableCopy];
    
    return monthesArr;
}

- (NSDate *)dateWithDateStr:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    return date;
}

- (NSString *)dateStrWithDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

/**
 获取指定日期的日历数据

 @param monthes 获取的月的个数
 @param fromDate 从该日期开始获取
 @return 日历数据
 */
- (NSMutableDictionary *)calendarDataWithMonthes:(NSInteger)monthes fromDate:(NSDate *)fromDate {
    
    if (monthesC == monthes && dateSource.allKeys.count == monthes) {
        return dateSource;
    }
    
    monthesC = monthes;
    
    NSMutableDictionary *calendarData = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < monthes; i++) {
        
        NSDate *curMonthDate = [self dateWithDateStr:[self monthsWithDate:fromDate monthes:monthes][i] format:@"yyyy年MM月"];
        
        // 该日期对应的月的首日是周几
        NSInteger firstWeekday = [self weekdayOfFirstDayInDate:curMonthDate];
        // 该日期对应的月的日期数
        NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:curMonthDate];
        
        // 取出字典对应月的数据数组
        NSMutableArray *monthArr = [NSMutableArray array];
        
        for (int j = 0; j < ceilf((totalDaysOfMonth + firstWeekday) / 7.0) * 7; j++) {
            
            if (j < firstWeekday) {
                [monthArr addObject:@{
                                      @"day":@"",
                                      @"chineseDay":@"",
                                      @"date":@""
                                      }];
            } else if (j >= totalDaysOfMonth + firstWeekday) {
                [monthArr addObject:@{
                                      @"day":@"",
                                      @"chineseDay":@"",
                                      @"date":@""
                                      }];
            } else {
                
                NSInteger day = j - firstWeekday + 1;
                
                NSDate *curDate = [self dateWithDateStr:[NSString stringWithFormat:@"%@%02ld日",[self monthsWithDate:fromDate monthes:monthes][i],(long)day] format:@"yyyy年MM月dd日"];
                
                NSDateComponents *comps0 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
                NSDateComponents *comps1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:curDate];
                
                if (comps0.year == comps1.year && comps0.month == comps1.month && comps0.day == comps1.day) {
                    [monthArr addObject:@{
                                          @"day":@"今天",
                                          @"chineseDay":[self chineseCalendarOfDate:curDate],
                                          @"date":curDate
                                          }];
                } else if (comps0.year == comps1.year && comps0.month == comps1.month && (comps0.day + 1) == comps1.day) {
                    [monthArr addObject:@{
                                          @"day":@"明天",
                                          @"chineseDay":[self chineseCalendarOfDate:curDate],
                                          @"date":curDate
                                          }];
                } else {
                    [monthArr addObject:@{
                                          @"day":[NSString stringWithFormat:@"%ld",(long)day],
                                          @"chineseDay":[self chineseCalendarOfDate:curDate],
                                          @"date":curDate
                                          }];
                }
            }
        }
        
        [calendarData setObject:monthArr forKey:[self monthsWithDate:fromDate monthes:monthes][i]];
    }
    
    dateSource = [calendarData mutableCopy];
    
    return dateSource;
}

@end
