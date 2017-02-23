//
//  CalendarDayCVCell.h
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDayCVCell : UICollectionViewCell
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *dayLab;
@property (nonatomic, strong) UILabel *chineseLab;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL isSelect;
@end
