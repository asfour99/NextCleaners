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


@end

@implementation SignUpController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=FALSE;
}
-(IBAction)nextBtnPressed:(id)sender
{
    AddressController *loginCon=[[AddressController alloc]initWithNibName:@"AddressController" bundle:nil];
    [self.navigationController pushViewController:loginCon animated:YES];

    
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
