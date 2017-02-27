//
//  ViewController.m
//  HLCalendar
//
//  Created by HL on 17/2/23.
//  Copyright © 2017年 花磊. All rights reserved.
//

#import "ViewController.h"
#import "HLCalendarVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UITextField *monthesNum;
@property (nonatomic, strong) NSDate *selectDate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClickAction:(id)sender {
    HLCalendarVC *vc = [[HLCalendarVC alloc] init];
    vc.monthesNum = [_monthesNum.text intValue];
    vc.selectDate = _selectDate ? _selectDate : [NSDate date];
    vc.selectDateBlock = ^(NSDate *date, NSString *dateStr) {
        _selectDate = date;
        [_btn setTitle:dateStr forState:UIControlStateNormal];
    };
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:naviVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
