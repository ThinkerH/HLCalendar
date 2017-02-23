//
//  CalendarDayCVCell.m
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "CalendarDayCVCell.h"

@implementation CalendarDayCVCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _backView.layer.cornerRadius = 4.0;
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = WHITE_COLOR;
        [self.contentView addSubview:_backView];
        
        _dayLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 4, frame.size.width, 20)];
        _dayLab.textColor = BLACK_TEXT_COLOR;
        _dayLab.font = FONT_TITLE1;
        _dayLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_dayLab];
        
        _chineseLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dayLab.frame), frame.size.width, 20)];
        _chineseLab.textColor = GRAY_TEXT_COLOR;
        _chineseLab.font = FONT_DESC;
        _chineseLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_chineseLab];
    }
    return self;
}
@end
