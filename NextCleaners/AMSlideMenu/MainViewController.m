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



@interface MainViewController ()  {
   
}

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
    
    [timeslotArray addObject:@"5.00 AM to 6.00 AM "];
    [timeslotArray addObject:@"6.00 AM to 7.00 AM "];
    [timeslotArray addObject:@"7.00 AM to 8.00 AM "];
    [timeslotArray addObject:@"8.00 AM to 9.00 AM "];
    [timeslotArray addObject:@"9.00 AM to 10.00 AM "];
    [timeslotArray addObject:@"10.00 AM to 11.00 AM "];
    
    
    
    
}

#define CG_CALENDAR_VIEW_HEIGHT 50


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)personInfoPicker
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)personInfoPicker numberOfRowsInComponent: (NSInteger)component
{
     return [timeslotArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
     return [timeslotArray objectAtIndex:row];
    
    
}
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
