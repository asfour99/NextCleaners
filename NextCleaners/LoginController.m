//
//  LoginController.m
//  NextCleaners
//
//  Created by Monika on 29/03/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "LoginController.h"
#import "FloatLabeledTextField.h"

@interface LoginController ()

@property(weak,nonatomic)IBOutlet FloatLabeledTextField *emailId_Field;
@property(weak,nonatomic)IBOutlet FloatLabeledTextField *password_Field;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=FALSE;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _emailId_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email*"
                                                                                        attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    _password_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password*"
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    return TRUE;
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
