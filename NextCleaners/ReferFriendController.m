//
//  ReferFriendController.m
//  NextCleaners
//
//  Created by Monika on 22/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "ReferFriendController.h"

@interface ReferFriendController ()

@property(weak,nonatomic) IBOutlet UIButton *referfriendBtn;

@end

@implementation ReferFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _referfriendBtn.layer.borderColor=[[UIColor clearColor]CGColor];
    _referfriendBtn.layer.borderWidth=1.0f;
    _referfriendBtn.layer.cornerRadius=4.0f;
    _referfriendBtn.layer.masksToBounds=YES;

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
