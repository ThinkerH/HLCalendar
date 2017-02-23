//
//  CalenderHeaderCRV.m
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "CalenderHeaderCRV.h"

@implementation CalenderHeaderCRV
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BACKGROUND_COLOR;
        
        _monthLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];//_monthLab.backgroundColor = BLUE_COLOR;
        _monthLab.textAlignment = NSTextAlignmentCenter;
        _monthLab.textColor = BLACK_TEXT_COLOR;
        _monthLab.font = FONT_TITLE17;
        [self addSubview:_monthLab];
        
        NSArray *weekDays = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        
        CGFloat labW = SCREEN_WIDTH / 7.0;
        CGFloat labH = 25;
        CGFloat y = 25;
        for (int i = 0; i < 7; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * labW, y, labW, labH)];//lab.backgroundColor = YELLOW_COLOR;
            lab.font = FONT_TEXT;
            lab.textAlignment = NSTextAlignmentCenter;
            if (i == 0 || i == 6) {
                lab.textColor = COLOR(35, 182, 245, 1.0);
            } else {
                lab.textColor = BLACK_TEXT_COLOR;
            }
            lab.text = weekDays[i];
            [self addSubview:lab];
        }
    }
    return self;
}
@end
