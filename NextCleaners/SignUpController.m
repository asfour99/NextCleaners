//
//  SignUpController.m
//  NextCleaners
//
//  Created by Monika on 01/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "SignUpController.h"
#import "AddressController.h"
#import "CardDetailsController.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION =0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface SignUpController ()
{
    
}
@property(weak,nonatomic)IBOutlet UITextField *emailId_Field;
@property(weak,nonatomic)IBOutlet UITextField *password_Field;
@property(weak,nonatomic)IBOutlet UITextField *firstName_Field;
@property(weak,nonatomic)IBOutlet UITextField *lastName_Field;
@property(weak,nonatomic)IBOutlet UITextField *phone_Field;
@property(weak,nonatomic)IBOutlet UIButton *signUpBtn;
@property(weak,nonatomic)IBOutlet UIButton *facebookBtn;


@end

@implementation SignUpController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=TRUE;
    _emailId_Field.layer.cornerRadius=8.0f;
    _emailId_Field.layer.masksToBounds=YES;
    _emailId_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _emailId_Field.layer.borderWidth= 1.0f;
    UIColor *color = [UIColor whiteColor];
    _emailId_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    _emailId_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _emailId_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _emailId_Field.textColor=[UIColor whiteColor];
    
    _password_Field.layer.cornerRadius=8.0f;
    _password_Field.layer.masksToBounds=YES;
    _password_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _password_Field.layer.borderWidth= 1.0f;
    _password_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    _password_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _password_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _password_Field.textColor=[UIColor whiteColor];
    
    _firstName_Field.layer.cornerRadius=8.0f;
    _firstName_Field.layer.masksToBounds=YES;
    _firstName_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _firstName_Field.layer.borderWidth= 1.0f;
    _firstName_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    _firstName_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _firstName_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _firstName_Field.textColor=[UIColor whiteColor];
    
    _lastName_Field.layer.cornerRadius=8.0f;
    _lastName_Field.layer.masksToBounds=YES;
    _lastName_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _lastName_Field.layer.borderWidth= 1.0f;
    _lastName_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    _lastName_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _lastName_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _lastName_Field.textColor=[UIColor whiteColor];
    
    _phone_Field.layer.cornerRadius=8.0f;
    _phone_Field.layer.masksToBounds=YES;
    _phone_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _phone_Field.layer.borderWidth= 1.0f;
    _phone_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone" attributes:@{NSForegroundColorAttributeName: color}];
    _phone_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _phone_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _phone_Field.textColor=[UIColor whiteColor];
    
    _signUpBtn.layer.cornerRadius=8.0f;
    _signUpBtn.layer.masksToBounds=YES;
    _signUpBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _signUpBtn.layer.borderWidth= 1.0f;
    
    _facebookBtn.layer.cornerRadius=8.0f;
    _facebookBtn.layer.masksToBounds=YES;
    _facebookBtn.layer.borderColor=[[UIColor clearColor]CGColor];
    _facebookBtn.layer.borderWidth= 1.0f;

}
-(IBAction)nextBtnPressed:(id)sender
{
    AddressController *loginCon=[[AddressController alloc]initWithNibName:@"AddressController" bundle:nil];
    [self.navigationController pushViewController:loginCon animated:YES];

    
}
-(IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)signUpBtnPressed:(id)sender
{
    CardDetailsController *loginCon=[[CardDetailsController alloc]initWithNibName:@"CardDetailsController" bundle:nil];
    [self.navigationController pushViewController:loginCon animated:YES];
    
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
