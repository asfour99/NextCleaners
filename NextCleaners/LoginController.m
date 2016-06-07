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
#import "APIKeys.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import "SideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "AppDelegate.h"


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
@synthesize HUD;

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
    
    
    [self ActivityBar];
}

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
    NSLog(@"%@",self.navigationController.viewControllers);
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)nextBtnPressed:(id)sender
{
//    UIViewController *menuController = [[JDMenuViewController alloc] init];
//    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    
//    //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
//                                                          menuController:menuController];
//    [self.navigationController pushViewController:sideMenu animated:YES];

    BOOL EMAIL_BOOL=FALSE;
    BOOL PASSWORD_BOOL=FALSE;
    if (_emailId_Field.text.length==0)
    {
        EMAIL_BOOL=TRUE;
    }
    if (_password_Field.text.length==0)
    {
        PASSWORD_BOOL=TRUE;
    }
    
    if (EMAIL_BOOL==FALSE && PASSWORD_BOOL==FALSE)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        [HUD show:YES];
        });
        APIHandler *apiHandler = [[APIHandler alloc] init] ;
        apiHandler.delegate = self ;
        [apiHandler loginApiCall:_emailId_Field.text password:_password_Field.text];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            CGFloat titlewidth=[self findwidth:@"Please fill all fields properly." fonname:FONT_LIGHT fontsize:20];
            
            [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Please fill all fields properly." widthofview:titlewidth];
            [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
        });
        
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
//- (MainViewController *)demoController {
//    return [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//}
//
//- (UINavigationController *)navigationController {
//    return [[UINavigationController alloc]
//            initWithRootViewController:[self demoController]];
//}

-(void)requestSucceded:(id)sender dicData:(NSDictionary *)apiData
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [HUD hide:YES];
    });
    NSString *successTag=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"success"]];
    
    if ([successTag isEqualToString:@"1"])
    {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            UINavigationController *navigationcontroller =[[UINavigationController alloc] initWithRootViewController:mainVC];
        JDMenuViewController *leftMenuViewController = [[JDMenuViewController alloc] init];
        //JDMenuViewController *rightMenuViewController = [[JDMenuViewController alloc] init];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:navigationcontroller
                                                        leftMenuViewController:leftMenuViewController
                                                        rightMenuViewController:nil];
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [container setPanMode:MFSideMenuPanModeNone];

            
        appDelegate.window.rootViewController = container;
        //[self.navigationController pushViewController:container animated:YES];
        });
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [HUD hide:YES];
//        UIViewController *menuController = [[JDMenuViewController alloc] init];
//        MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//        
//        //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//        JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
//                                                              menuController:menuController];
//        [self.navigationController pushViewController:sideMenu animated:YES];
//        });
    }
    else
    {
        //[HUD hide:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [HUD hide:YES];
            CGFloat titlewidth=[self findwidth:[apiData objectForKey:@"message"] fonname:FONT_LIGHT fontsize:20];
            
            [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:[apiData objectForKey:@"message"] widthofview:titlewidth];
            [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
            
        });
        

//        NSString *errorMsg=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"message"]];
//        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [error show];
        
    }
    
    
    
}
-(void)requestFailed:(id)sender getval:(NSString*)errodesc
{
//    [HUD hide:YES];
//    NSString *errorMsg=[NSString stringWithFormat:@"%@",errodesc];
//    UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [error show];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [HUD hide:YES];
        NSString *errorMsg=[NSString stringWithFormat:@"%@",errodesc];
        CGFloat titlewidth=[self findwidth:errorMsg fonname:FONT_LIGHT fontsize:20];
        
        [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:errorMsg widthofview:titlewidth];
        [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
        
    });

    
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

- (IBAction)loginWithFacebookAction:(id) sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [HUD show:YES];
    });
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 
                 [HUD hide:YES];
                 CGFloat titlewidth=[self findwidth:@"Something went wrong,Please try later." fonname:FONT_LIGHT fontsize:20];
                 
                 [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Something went wrong,Please try later." widthofview:titlewidth];
                 [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];

             });
             
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             if ([result.grantedPermissions containsObject:@"public_profile"])
             {
                 
                 NSLog(@"result is:%@",result);
                 [self fetchUserInfo];
             }
         }
     }];
}
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        //API CALLING
        
        APIHandler *apiHandler = [[APIHandler alloc] init] ;
        apiHandler.delegate = self ;
        [apiHandler loginApiCall:_emailId_Field.text password:@"FBTEMP123"];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
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
