//
//  HLCalendarVC.h
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectDateBlock)(NSDate *date, NSString *dateStr);

@interface HLCalendarVC : UIViewController
@property (nonatomic, assign) int monthesNum;
@property (strong, nonatomic) NSDate *selectDate;
@property (nonatomic, copy) SelectDateBlock selectDateBlock;
@end
