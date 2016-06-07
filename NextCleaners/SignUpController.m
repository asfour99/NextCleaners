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
#import "APIKeys.h"

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
@synthesize HUD;


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
    
    [self ActivityBar];
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _phone_Field.inputAccessoryView = keyboardDoneButtonView;


}
- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}

//-(IBAction)nextBtnPressed:(id)sender
//{
//    AddressController *loginCon=[[AddressController alloc]initWithNibName:@"AddressController" bundle:nil];
//    [self.navigationController pushViewController:loginCon animated:YES];
//
//    
//}

-(void)ActivityBar
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.dimBackground = YES;
    
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    
    
    
    // Show the HUD while the provided method executes in a new thread
    
    //[HUD showWhileExecuting:@selector(showLoder) onTarget:self withObject:nil animated:YES];
}

-(IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)signUpBtnPressed:(id)sender
{
    BOOL firstName_Bool=FALSE;
    BOOL lastName_Bool=FALSE;
    BOOL email_Bool=FALSE;
    BOOL phone_Bool=FALSE;
    BOOL password_Bool=FALSE;
    
    if (_firstName_Field.text.length==0)
    {
        firstName_Bool=TRUE;
    }
    if (_lastName_Field.text.length==0)
    {
        lastName_Bool=TRUE;
    }
    if (_emailId_Field.text.length==0)
    {
        email_Bool=TRUE;
    }
    if (_phone_Field.text.length==0)
    {
        phone_Bool=TRUE;
    }
    if (_password_Field.text.length==0)
    {
        password_Bool=TRUE;
    }
    if (_phone_Field.text.length!=10)
    {
        phone_Bool=TRUE;
    }
    if (_password_Field.text.length<6) {
        password_Bool=TRUE;
    }
    
    if (firstName_Bool==FALSE&& lastName_Bool==FALSE&&email_Bool==FALSE&&phone_Bool==FALSE&&password_Bool==FALSE) {
        [_firstName_Field resignFirstResponder];
        [_lastName_Field resignFirstResponder];
        [_emailId_Field resignFirstResponder];
        [_phone_Field resignFirstResponder];
        [_password_Field resignFirstResponder];
        
        
        APIHandler *apiHandler = [[APIHandler alloc] init] ;
        apiHandler.delegate = self ;
        [HUD show:YES];
        //[apiHandler retrievebookingapi:methodname tag:TAG_FLIGHT_SHEDULE_API pnrNo:@"" lastname:@""];
        [apiHandler signUpApiCall:@"" firstName:_firstName_Field.text lastName:_lastName_Field.text emailId:_emailId_Field.text phoneNum:_phone_Field.text password:_password_Field.text];
        
    }
    else
    {
        if (firstName_Bool==TRUE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                
                CGFloat titlewidth=[self findwidth:@"Please Enter FirstName" fonname:FONT_LIGHT fontsize:20];
                
                [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Please Enter FirstName" widthofview:titlewidth];
                [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            });
 
        }
        else if (lastName_Bool==TRUE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                
                CGFloat titlewidth=[self findwidth:@"Please Enter LastName" fonname:FONT_LIGHT fontsize:20];
                
                [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Please Enter LastName" widthofview:titlewidth];
                [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            });

        }
        else if (email_Bool==TRUE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                
                CGFloat titlewidth=[self findwidth:@"Please Enter EmailID" fonname:FONT_LIGHT fontsize:20];
                
                [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Please Enter EmailID" widthofview:titlewidth];
                [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            });

        }
        else if (phone_Bool==TRUE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                
                CGFloat titlewidth=[self findwidth:@"Phone Number should be 10 digit" fonname:FONT_LIGHT fontsize:20];
                
                [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Phone Number should be 10 digit" widthofview:titlewidth];
                [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            });

        }
        else if (password_Bool==TRUE)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                
                CGFloat titlewidth=[self findwidth:@"Password should be geater than 6 digit" fonname:FONT_LIGHT fontsize:20];
                
                [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Password should be geater than 6 digit" widthofview:titlewidth];
                [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            });

        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [HUD hide:YES];
                
                CGFloat titlewidth=[self findwidth:@"Please check all fields" fonname:FONT_LIGHT fontsize:20];
                
                [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Please check all fields" widthofview:titlewidth];
                [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            });

        }
        

        
    }
    
    
    
}
-(CGFloat)findwidth:(NSString *)textname fonname:(NSString*)fontname fontsize:(float)fontsize
{
    return  ceil([textname sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:fontname size:fontsize]}].width);
}
-(void)hideSuccessView
{
    [FVCustomAlertView hideAlertFromView:self.view fading:YES];
    
}
-(void)requestSucceded:(id)sender dicData:(NSDictionary *)apiData
{
    NSString *successTag=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"success"]];
    NSString *userID=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"id"]];
     dispatch_async(dispatch_get_main_queue(), ^{
    [HUD hide:YES];
     });
    
    if ([successTag isEqualToString:@"1"])
    {
         dispatch_async(dispatch_get_main_queue(), ^{
        CardDetailsController *loginCon=[[CardDetailsController alloc]initWithNibName:@"CardDetailsController" bundle:nil];
        loginCon.userId=userID;
        [self.navigationController pushViewController:loginCon animated:YES];
         });
    }
    else
    {
         dispatch_async(dispatch_get_main_queue(), ^{
        NSString *errorMsg=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"message"]];
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
        [error show];
         });
        
    }
    
    
    
}
-(void)requestFailed:(id)sender getval:(NSString*)errodesc
{
     dispatch_async(dispatch_get_main_queue(), ^{
    [HUD hide:YES];
     });
    
    NSString *errorMsg=[NSString stringWithFormat:@"%@",errodesc];
    UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
    [error show];
    
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
