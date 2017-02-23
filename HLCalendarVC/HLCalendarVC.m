//
//  HLCalendarVC.m
//  uj-golf_course
//
//  Created by HL on 17/2/10.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "HLCalendarVC.h"
#import "HLCalendar.h"
#import "CalenderHeaderCRV.h"
#import "CalendarDayCVCell.h"


/****************************************************************************************************/

#define CollectionViewHorizonMargin 5
#define CollectionViewVerticalMargin 5

#define calendarLenth  6 // 取本月开始几个月的日历数据

@interface HLCalendarVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *monthes;
@property (nonatomic, strong) NSMutableDictionary *dateSource;

@end

@implementation HLCalendarVC

- (void)cancleBtnAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择日期";
    self.view.backgroundColor = WHITE_COLOR;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancleBtnAction)];
    
    
    _monthes = [[HLCalendar shareInstance] monthsWithDate:[NSDate date] monthes:calendarLenth];
    _dateSource = [[HLCalendar shareInstance] calendarDataWithMonthes:calendarLenth fromDate:[NSDate date]];
    
    [self setupCollectionView];
    
}

- (void)setupCollectionView {
    CGFloat itemWidth = (SCREEN_WIDTH - CollectionViewHorizonMargin * 2) / 7;
    CGFloat itemHeight = itemWidth + 4;
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);
    flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayot.minimumLineSpacing = 0;
    flowLayot.minimumInteritemSpacing = 0;
    
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayot];
    [self.view addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[CalendarDayCVCell class] forCellWithReuseIdentifier:@"CalendarCell"];
    [self.collectionView registerClass:[CalenderHeaderCRV class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CalendarHeader"];
}

#pragma mark - UICollectionDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!_dateSource) {
        return 0;
    } else {
        return _dateSource.allKeys.count;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    NSDate *curMonthDate = [HLCalendar dateWithDateStr:[HLCalendar monthsWithDate:[NSDate date] monthes:calendarLenth][section] format:@"yyyy年MM月"];
//    
//    NSInteger firstWeekday = [HLCalendar weekdayOfFirstDayInDate:curMonthDate];
//    
//    NSInteger totalDaysOfMonth = [HLCalendar totalDaysInMonthOfDate:curMonthDate];
//    
//    return ceilf((totalDaysOfMonth + firstWeekday) / 7.0) * 7;
    
    return [_dateSource[_monthes[section]] count];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        static NSString *ident = @"CalendarHeader";
        CalenderHeaderCRV *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ident forIndexPath:indexPath];
        header.monthLab.text = _monthes[indexPath.section];
        
        return header;
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CalendarCell";
    CalendarDayCVCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.dayLab.text = _dateSource[_monthes[indexPath.section]][indexPath.row][@"day"];
    cell.chineseLab.text = _dateSource[_monthes[indexPath.section]][indexPath.row][@"chineseDay"];
    if ([_dateSource[_monthes[indexPath.section]][indexPath.row][@"date"] isKindOfClass:[NSDate class]]) {
        cell.date = _dateSource[_monthes[indexPath.section]][indexPath.row][@"date"];
        cell.userInteractionEnabled = YES;
        
        // 今天
        NSDateComponents *compsToDay = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        // 当前日
        NSDateComponents *compsCurDay = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:cell.date];
        
        //选中状态
        if (_selectDate) {
            // 选中日
            NSDateComponents *compsSelDay = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:_selectDate];
            
            if (compsSelDay.year == compsCurDay.year && compsSelDay.month == compsCurDay.month && compsSelDay.day == compsCurDay.day) {
                
                cell.isSelect = YES;
            } else {
                
                cell.isSelect = NO;
            }
            
        } else {
            if(compsToDay.year == compsCurDay.year && compsToDay.month == compsCurDay.month && compsToDay.day == compsCurDay.day) {
                cell.isSelect = YES;
            } else {
                cell.isSelect = NO;
            }
        }
        
        if (cell.isSelect) {
            cell.backView.backgroundColor = MAIN_COLOR;
            
            cell.dayLab.textColor = WHITE_COLOR;
            cell.chineseLab.textColor = WHITE_COLOR;
        } else {
            cell.backView.backgroundColor = WHITE_COLOR;
            
            cell.chineseLab.textColor = GRAY_TEXT_COLOR;
            if (compsToDay.year == compsCurDay.year && compsToDay.month == compsCurDay.month && compsToDay.day > compsCurDay.day) {
                cell.dayLab.textColor = GRAY_TEXT_COLOR;
                cell.userInteractionEnabled = NO;
            } else {
                cell.userInteractionEnabled = YES;
                if ([[HLCalendar shareInstance] weekdayOfDate:cell.date] == 0 || [[HLCalendar shareInstance] weekdayOfDate:cell.date] == 6) {
                    cell.dayLab.textColor = COLOR(35, 182, 245, 1.0);
                } else {
                    cell.dayLab.textColor = BLACK_TEXT_COLOR;
                }
            }
        }
    } else {
        cell.backView.backgroundColor = WHITE_COLOR;
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarDayCVCell *cell = (CalendarDayCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (_selectDateBlock) {
        
        _selectDate = cell.date;
        [_collectionView reloadData];
        
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        f.dateFormat = @"MM月dd日";
        
        _selectDateBlock(cell.date,[NSString stringWithFormat:@"%@%@",[f stringFromDate:cell.date],[[HLCalendar shareInstance] weekDayStrOfDate:cell.date]]);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
