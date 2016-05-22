//
//  LoginController.m
//  NextCleaners
//
//  Created by Monika on 29/03/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "LoginController.h"
#import "FloatLabeledTextField.h"
#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "JDSideMenu.h"
#import "JDMenuViewController.h"
static const CGFloat KEYBOARD_ANIMATION_DURATION =0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
//SS///
@interface LoginController ()

@property(weak,nonatomic)IBOutlet UITextField *emailId_Field;
@property(weak,nonatomic)IBOutlet UITextField *password_Field;
@property(weak,nonatomic)IBOutlet UIButton *signinBtn;

@property(weak,nonatomic)IBOutlet UIButton *facebookBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    //// Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=TRUE;
    
    

    _emailId_Field.layer.cornerRadius=8.0f;
    _emailId_Field.layer.masksToBounds=YES;
    _emailId_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _emailId_Field.layer.borderWidth= 2.0f;
    UIColor *color = [UIColor whiteColor];
    _emailId_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    _emailId_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _emailId_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _emailId_Field.textColor=[UIColor whiteColor];
    
    _password_Field.layer.cornerRadius=8.0f;
    _password_Field.layer.masksToBounds=YES;
    _password_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _password_Field.layer.borderWidth= 2.0f;
    _password_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    _password_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _password_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _password_Field.textColor=[UIColor whiteColor];
    
    _signinBtn.layer.cornerRadius=8.0f;
    _signinBtn.layer.masksToBounds=YES;
    _signinBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _signinBtn.layer.borderWidth= 1.0f;
    
    _facebookBtn.layer.cornerRadius=8.0f;
    _facebookBtn.layer.masksToBounds=YES;
    _facebookBtn.layer.borderColor=[[UIColor clearColor]CGColor];
    _facebookBtn.layer.borderWidth= 1.0f;
}

-(IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)nextBtnPressed:(id)sender
{
    UIViewController *menuController = [[JDMenuViewController alloc] init];
    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
                                                          menuController:menuController];
    [self.navigationController pushViewController:sideMenu animated:YES];
    
}


//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    return TRUE;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // the user pressed the "Done" button, so dismiss the keyboard
    
    [textField resignFirstResponder];
    
    
    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2];
    
    [UIView commitAnimations];
    //    NSString *dateStr = [df stringFromDate:datePciker.date];
    //    NSLog(@"datestring== %@",dateStr);
    
    
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait   )
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    //[contentView setFrame:viewFrame];
    
    [UIView commitAnimations];
    
        NSLog(@"ert=%f",animatedDistance);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    // [contentView setFrame:viewFrame];
    
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    if ( viewFrame.origin.y>0)
    {
        viewFrame.origin.y=60;
    }
    else
    {
        
    }
    NSLog(@"ert=%f",animatedDistance);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    // [contentView setFrame:viewFrame];
    
    [UIView commitAnimations];
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
