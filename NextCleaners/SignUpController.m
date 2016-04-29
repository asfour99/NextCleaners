//
//  SignUpController.m
//  NextCleaners
//
//  Created by Monika on 01/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "SignUpController.h"
#import "AddressController.h"

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
    _emailId_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"    Email" attributes:@{NSForegroundColorAttributeName: color}];
    
    _password_Field.layer.cornerRadius=8.0f;
    _password_Field.layer.masksToBounds=YES;
    _password_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _password_Field.layer.borderWidth= 1.0f;
    _password_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"    Password" attributes:@{NSForegroundColorAttributeName: color}];
    
    _firstName_Field.layer.cornerRadius=8.0f;
    _firstName_Field.layer.masksToBounds=YES;
    _firstName_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _firstName_Field.layer.borderWidth= 1.0f;
    _firstName_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"    First Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    _lastName_Field.layer.cornerRadius=8.0f;
    _lastName_Field.layer.masksToBounds=YES;
    _lastName_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _lastName_Field.layer.borderWidth= 1.0f;
    _lastName_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"    Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    _phone_Field.layer.cornerRadius=8.0f;
    _phone_Field.layer.masksToBounds=YES;
    _phone_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _phone_Field.layer.borderWidth= 1.0f;
    _phone_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"    Phone" attributes:@{NSForegroundColorAttributeName: color}];
    
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
