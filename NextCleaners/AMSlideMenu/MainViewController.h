//
//  MainViewController.h
//  NextCleaners
//
//  Created by Monika on 12/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"

@interface MainViewController : UIViewController<JTCalendarDelegate>
@property(retain,nonatomic) NSMutableArray *timeslotArray;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@end
