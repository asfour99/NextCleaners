//
//  CardDetailsController.m
//  NextCleaners
//
//  Created by Monika on 29/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "CardDetailsController.h"
#import "AddressController.h"
static const CGFloat KEYBOARD_ANIMATION_DURATION =0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface CardDetailsController ()

@property(weak,nonatomic)IBOutlet UITextField *cardNo_Field;
@property(weak,nonatomic)IBOutlet UITextField *cvc_Field;
@property(weak,nonatomic)IBOutlet UITextField *zipCode_Field;
//@property(weak,nonatomic)IBOutlet UITextField *lastName_Field;
//@property(weak,nonatomic)IBOutlet UITextField *phone_Field;
@property(weak,nonatomic)IBOutlet UIButton *monthBtn;
@property(weak,nonatomic)IBOutlet UIButton *yearBtn;
@property(weak,nonatomic)IBOutlet UIButton *cardBtn;
@property(weak,nonatomic)IBOutlet UIButton *nextBtn;

@end

@implementation CardDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden=TRUE;
    _cardNo_Field.layer.cornerRadius=8.0f;
    _cardNo_Field.layer.masksToBounds=YES;
    _cardNo_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _cardNo_Field.layer.borderWidth= 1.0f;
    UIColor *color = [UIColor whiteColor];
    _cardNo_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Card #" attributes:@{NSForegroundColorAttributeName: color}];
    _cardNo_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _cardNo_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _cardNo_Field.textColor=[UIColor whiteColor];
    
    _cvc_Field.layer.cornerRadius=8.0f;
    _cvc_Field.layer.masksToBounds=YES;
    _cvc_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _cvc_Field.layer.borderWidth= 1.0f;
    
    _cvc_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CVC" attributes:@{NSForegroundColorAttributeName: color}];
    _cvc_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _cvc_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _cvc_Field.textColor=[UIColor whiteColor];
    
    _zipCode_Field.layer.cornerRadius=8.0f;
    _zipCode_Field.layer.masksToBounds=YES;
    _zipCode_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _zipCode_Field.layer.borderWidth= 1.0f;
    _zipCode_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip Code" attributes:@{NSForegroundColorAttributeName: color}];
    _zipCode_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _zipCode_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _zipCode_Field.textColor=[UIColor whiteColor];
    
    _monthBtn.layer.cornerRadius=8.0f;
    _monthBtn.layer.masksToBounds=YES;
    _monthBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _monthBtn.layer.borderWidth= 1.0f;
    
    _yearBtn.layer.cornerRadius=8.0f;
    _yearBtn.layer.masksToBounds=YES;
    _yearBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _yearBtn.layer.borderWidth= 1.0f;
    



}
-(IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)nextBtnPressed:(id)sender
{
    AddressController *loginCon=[[AddressController alloc]initWithNibName:@"AddressController" bundle:nil];
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
