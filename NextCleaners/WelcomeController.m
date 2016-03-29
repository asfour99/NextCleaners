//
//  WelcomeController.m
//  NextCleaners
//
//  Created by Monika on 29/03/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "WelcomeController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "APIKeys.h"
#import "LoginController.h"





@interface WelcomeController ()



@end

@implementation WelcomeController
@synthesize playercontroller;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // pick a video from the documents directory
    self.navigationController.navigationBarHidden=TRUE;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"onboarding1" ofType:@"mp4"]];
    playercontroller = [[MPMoviePlayerViewController alloc]
                                                     initWithContentURL:url];
    [[playercontroller view] setFrame:[self.view bounds]];
    playercontroller.moviePlayer.controlStyle=MPMovieControlStyleNone;
    playercontroller.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    playercontroller.moviePlayer.scalingMode=MPMovieScalingModeFill;
    [self.view addSubview:[playercontroller view]];
    //playercontroller.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [playercontroller.moviePlayer play];
    
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100, 200, 40)];
    titleLbl.text=@"NEXT CLEANERS";
    titleLbl.font=[UIFont systemFontOfSize:18];
    titleLbl.textColor=[UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    UIButton *signUp=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-120,SCREEN_HEIGHT/2, 100, 40)];
    [signUp setTitle:@"SIGNUP" forState:UIControlStateNormal];
    [signUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    signUp.layer.cornerRadius = 8.0f;
    signUp.layer.masksToBounds = NO;
    signUp.layer.borderWidth = 1.0f;
    signUp.backgroundColor=[UIColor whiteColor];
    signUp.layer.shadowColor = [UIColor grayColor].CGColor;
    signUp.layer.shadowOpacity = 0.8;
    signUp.layer.shadowRadius = 12;
    signUp.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    [self.view addSubview:signUp];
    
    UIButton *logiBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+20,SCREEN_HEIGHT/2, 100, 40)];
    [logiBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    [logiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    logiBtn.backgroundColor=[UIColor whiteColor];
    logiBtn.layer.cornerRadius = 8.0f;
    logiBtn.layer.masksToBounds = NO;
    logiBtn.layer.borderWidth = 1.0f;
    [logiBtn addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
    logiBtn.layer.shadowColor = [UIColor grayColor].CGColor;
    logiBtn.layer.shadowOpacity = 0.8;
    logiBtn.layer.shadowRadius = 12;
    logiBtn.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
    [self.view addSubview:logiBtn];
    
   
    NSLog(@"Video is Playing");
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=TRUE;
    [playercontroller.moviePlayer play];
    
}
-(IBAction)loginPressed:(id)sender
{
    LoginController *loginCon=[[LoginController alloc]initWithNibName:@"LoginController" bundle:nil];
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
