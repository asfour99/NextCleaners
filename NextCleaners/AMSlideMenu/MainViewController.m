//
//  MainViewController.m
//  NextCleaners
//
//  Created by Monika on 12/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "MainViewController.h"
#import "ReferFriendController.h"
#import "PreferencesController.h"
#import <QuartzCore/QuartzCore.h>
#import "JDMenuViewController.h"
#import "JDSideMenu.h"
#import "CLWeeklyCalendarView.h"

#define CG_CALENDAR_VIEW_HEIGHT 50


@interface MainViewController  () {
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    
    NSDate *_dateSelected;

   
}
//@property (nonatomic, strong) CLWeeklyCalendarView* calendarView;

@property(retain,nonatomic) IBOutlet UIPickerView *timeIntervalPicker;
@property(retain,nonatomic) IBOutlet UIButton *repeatBtn;
@property(retain,nonatomic) IBOutlet UIButton *placeOrder;
@property(retain,nonatomic) IBOutlet UIButton *referFriendBtn;
@property(retain,nonatomic) IBOutlet UIButton *preferencesBtn;
@property(retain,nonatomic) IBOutlet UIView *orderPlaceSuccessView;
@property(retain,nonatomic) IBOutlet UIScrollView *mainScroller;


@end

@implementation MainViewController
@synthesize timeslotArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _repeatBtn.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _repeatBtn.layer.borderWidth=1.0f;
    _repeatBtn.layer.cornerRadius=4.0f;
    _repeatBtn.layer.masksToBounds=YES;
    
    _placeOrder.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _placeOrder.layer.borderWidth=1.0f;
    _placeOrder.layer.cornerRadius=4.0f;
    _placeOrder.layer.masksToBounds=YES;
    
    _referFriendBtn.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _referFriendBtn.layer.borderWidth=1.0f;
    _referFriendBtn.layer.cornerRadius=4.0f;
    _referFriendBtn.layer.masksToBounds=YES;
    
    _preferencesBtn.layer.borderColor=[[UIColor colorWithRed:122.0/255.0f green:192/255.0f blue:66/255.0f alpha:1.0]CGColor];
    _preferencesBtn.layer.borderWidth=1.0f;
    _preferencesBtn.layer.cornerRadius=4.0f;
    _preferencesBtn.layer.masksToBounds=YES;
    
    timeslotArray=[[NSMutableArray alloc]init];
    
    [timeslotArray addObject:@"5.00 to 6.00 AM "];
    [timeslotArray addObject:@"6.00 to 7.00 AM "];
    [timeslotArray addObject:@"7.00 to 8.00 AM "];
    [timeslotArray addObject:@"8.00 to 9.00 AM "];
    [timeslotArray addObject:@"9.00 to 10.00 AM "];
    [timeslotArray addObject:@"10.00 to 11.00 AM "];
    
    //[_mainScroller addSubview:self.calendarView];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    [self createMinAndMaxDate];
    
//    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
    _calendarManager.settings.weekModeEnabled = YES;
    [_calendarManager reload];
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }

self.calendarContentViewHeight.constant = newHeight;
    [_timeIntervalPicker selectRow:4 inComponent:0 animated:YES];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _orderPlaceSuccessView.hidden=TRUE;
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
    label.font = [UIFont fontWithName:@"montserrat-light" size:20];
    label.text = [NSString stringWithFormat:@" %@", [timeslotArray objectAtIndex:row]];
    return label;    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)personInfoPicker
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)personInfoPicker numberOfRowsInComponent: (NSInteger)component
{
     return [timeslotArray count];
    
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    
//     return [timeslotArray objectAtIndex:row];
//    
//    
//}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel* label = (UILabel*)view;
//    
//    
//    label.textColor = [UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
//    label.font=[UIFont fontWithName:@"montserrat-light" size:12];
//    label.text=[timeslotArray objectAtIndex:row];
//    return label;
//}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 30.0f;
    
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //[mainPicker reloadAllComponents];
    
    
}

-(IBAction)crossBtnPressed:(id)sender
{
    _orderPlaceSuccessView.hidden=TRUE;
}

-(IBAction)placeOrderAction:(id)sender
{
    
        _orderPlaceSuccessView.hidden=FALSE;
}
-(IBAction)referFriendBtnAction:(id)sender
{
//    ReferFriendController *loginCon=[[ReferFriendController alloc]initWithNibName:@"ReferFriendController" bundle:nil];
//    [self.navigationController pushViewController:loginCon animated:YES];
    UIViewController *menuController = [[JDMenuViewController alloc] init];
    ReferFriendController *mainVC = [[ReferFriendController alloc] initWithNibName:@"ReferFriendController" bundle:nil];
    
    //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
                                                          menuController:menuController];
    [self.navigationController pushViewController:sideMenu animated:YES];
    
}

-(IBAction)preferencesBtnAction:(id)sender
{
//    PreferencesController *loginCon=[[PreferencesController alloc]initWithNibName:@"PreferencesController" bundle:nil];
//    [self.navigationController pushViewController:loginCon animated:YES];
    
    UIViewController *menuController = [[JDMenuViewController alloc] init];
    PreferencesController *mainVC = [[PreferencesController alloc] initWithNibName:@"PreferencesController" bundle:nil];
    
    //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
                                                          menuController:menuController];
    [self.navigationController pushViewController:sideMenu animated:YES];

    
}
- (IBAction)didGoTodayTouch
{
    [_calendarManager setDate:_todayDate];
}

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
        //dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
        //dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        //dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        //dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
//    if([self haveEventForDay:dayView.date]){
//        dayView.dotView.hidden = NO;
//    }
//    else{
//        dayView.dotView.hidden = YES;
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    return [_calendarManager.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
}

#pragma mark - Fake data

- (void)createMinAndMaxDate
{
    _todayDate = [NSDate date];
    
    // Min date will be 2 month before today
    _minDate = [_calendarManager.dateHelper addToDate:_todayDate months:-2];
    
    // Max date will be 2 month after today
    _maxDate = [_calendarManager.dateHelper addToDate:_todayDate months:2];
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
//    NSString *key = [[self dateFormatter] stringFromDate:date];
//    
//    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
//        return YES;
//    }
//
    return NO;
    
}

- (void)createRandomEvents
{
//    _eventsByDate = [NSMutableDictionary new];
//    
//    for(int i = 0; i < 30; ++i){
//        // Generate 30 random dates between now and 60 days later
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//        
//        // Use the date as key for eventsByDate
//        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
//        
//        if(!_eventsByDate[key]){
//            _eventsByDate[key] = [NSMutableArray new];
//        }
//        
//        [_eventsByDate[key] addObject:randomDate];
//    }
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
