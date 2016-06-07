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
#import "SignUpController.h"
#import "APIHandler.h"





@interface WelcomeController ()
//@property(weak,nonatomic) IBOutlet UIScrollView *mainScroler;
//@property(weak,nonatomic) IBOutlet UIPageControl *pageControl;



@end

@implementation WelcomeController
//@synthesize playercontroller;

- (void)viewDidLoad  {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    // pick a video from the documents directory
    self.navigationController.navigationBarHidden=TRUE;
    UIScrollView *scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scr.userInteractionEnabled=TRUE;
    scr.tag = 1;
    //scr.autoresizingMask=UIViewAutoresizingNone;
   

    [self.view addSubview:scr];
    [self setupScrollView:scr];
          // [self setupScrollView:_mainScroler];
//    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100, 200, 40)];
//    titleLbl.text=@"NEXT CLEANERS";
//    titleLbl.font=[UIFont systemFontOfSize:18];
//    titleLbl.textColor=[UIColor blackColor];
//    [self.view addSubview:titleLbl];
    
    UIButton *signUp=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-120,SCREEN_HEIGHT-150, 100, 40)];
    [signUp setBackgroundImage:[UIImage imageNamed:@"SignUp_Inactive.png"] forState:UIControlStateNormal];
    [signUp setBackgroundImage:[UIImage imageNamed:@"SignUp_Active.png"] forState:UIControlStateHighlighted];

    [signUp addTarget:self action:@selector(signUpPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUp];
//
    UIButton *logiBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+20,SCREEN_HEIGHT-150, 100, 40)];
    [logiBtn setBackgroundImage:[UIImage imageNamed:@"LogIn_Inactive.png"] forState:UIControlStateNormal];
    [logiBtn addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
    [logiBtn setBackgroundImage:[UIImage imageNamed:@"LogIn_Active.png"] forState:UIControlStateHighlighted];
   
    [self.view addSubview:logiBtn];
    
    UIPageControl *pgCtr = [[UIPageControl alloc] initWithFrame:CGRectMake(0,logiBtn.frame.origin.y-50, SCREEN_WIDTH, 36)];
    [pgCtr setTag:12];
    pgCtr.numberOfPages=4;
    pgCtr.userInteractionEnabled=TRUE;
    
    pgCtr.pageIndicatorTintColor = [UIColor whiteColor];
    pgCtr.currentPageIndicatorTintColor = [UIColor greenColor];
    pgCtr.autoresizingMask=UIViewAutoresizingNone;
    [self.view addSubview:pgCtr];

    //NSLog(@"Video is Playing");
    
    
}



- (void)setupScrollView:(UIScrollView*)scrMain {
    // we have 10 images here.
    // we will add all images into a scrollView &amp; set the appropriate size.
    
    for (int i=1;i<=4; i++) {
        
        NSString *imagename=@"";
        
        if (i==1)
        {
            imagename=@"Login_iPhone.png";
        }
        else if(i==2)
        {
            imagename=@"On_Demand.png";
        }
        else if(i==3)
        {
           imagename=@"Dry_Cleaning.png";
        }
        else if(i==4)
        {
            imagename=@"Customer_Service.png";
        }
        
        // create image
        UIImage *image = [UIImage imageNamed:imagename];
        // create imageView
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i-1)*scrMain.frame.size.width, 0, scrMain.frame.size.width, SCREEN_HEIGHT)];
        // set scale to fill
        imgV.contentMode=UIViewContentModeScaleToFill;
        // set image
        [imgV setImage:image];
        // apply tag to access in future
        imgV.tag=i+1;
        // add to scrollView
        [scrMain addSubview:imgV];
    }
    // set the content size to 10 image width
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*4, SCREEN_HEIGHT)];
    // enable timer after each 2 seconds for scrolling.
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}


- (void)scrollingTimer {
    // access the scroll view with the tag
    UIScrollView *scrMain = (UIScrollView*) [self.view viewWithTag:1];
    // same way, access pagecontroll access
    UIPageControl *pgCtr = (UIPageControl*) [self.view viewWithTag:12];
    // get the current offset ( which page is being displayed )
    CGFloat contentOffset = scrMain.contentOffset.x;
    // calculate next page to display
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    // if page is not 10, display it
    if( nextPage!=4 )  {
        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, 0, scrMain.frame.size.width, SCREEN_HEIGHT) animated:YES];
        pgCtr.currentPage=nextPage;
        // else start sliding form 1 :)
    } else {
        [scrMain scrollRectToVisible:CGRectMake(0, 0, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        pgCtr.currentPage=0;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=TRUE;
    
    
}
-(IBAction)loginPressed:(id)sender
{
    LoginController *loginCon=[[LoginController alloc]initWithNibName:@"LoginController" bundle:nil];
    [self.navigationController pushViewController:loginCon animated:YES];
    
}
-(IBAction)signUpPressed:(id)sender
{
    SignUpController *loginCon=[[SignUpController alloc]initWithNibName:@"SignUpController" bundle:nil];
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
