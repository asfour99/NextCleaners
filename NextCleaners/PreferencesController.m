//
//  PreferencesController.m
//  NextCleaners
//
//  Created by Monika on 22/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "PreferencesController.h"
#import "MFSideMenu.h"

@interface PreferencesController ()
@property(retain,nonatomic) IBOutlet NSLayoutConstraint *segmentHeight;
@property(retain,nonatomic) IBOutlet UISegmentedControl *segment1;
@property(retain,nonatomic) IBOutlet NSLayoutConstraint *segmentHeight2;
@property(retain,nonatomic) IBOutlet UISegmentedControl *segment2;
@property(retain,nonatomic) IBOutlet NSLayoutConstraint *segmentHeight3;
@property(retain,nonatomic) IBOutlet UISegmentedControl *segment3;
@property(retain,nonatomic) IBOutlet UIView *specialInstructionView;
@property(retain,nonatomic) IBOutlet NSLayoutConstraint *segmentHeight4;
@property(retain,nonatomic) IBOutlet UISegmentedControl *segment4;
@property(retain,nonatomic) IBOutlet UIButton *savePrefernceBtn;


@end

@implementation PreferencesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _segmentHeight.constant=40;
    _segmentHeight2.constant=40;
    _segmentHeight3.constant=40;
    _segmentHeight4.constant=40;
    
    _segment1.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _segment1.layer.borderWidth=2.0f;
    _segment1.layer.cornerRadius=8.0f;
    _segment1.layer.masksToBounds=YES;
    
    [_segment1 setTintColor:[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]];
    
    _segment2.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _segment2.layer.borderWidth=2.0f;
    _segment2.layer.cornerRadius=8.0f;
    _segment2.layer.masksToBounds=YES;
    
    [_segment2 setTintColor:[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]];
    
    
    _segment3.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _segment3.layer.borderWidth=2.0f;
    _segment3.layer.cornerRadius=8.0f;
    _segment3.layer.masksToBounds=YES;
    
    [_segment3 setTintColor:[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]];
    
    _segment4.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _segment4.layer.borderWidth=2.0f;
    _segment4.layer.cornerRadius=8.0f;
    _segment4.layer.masksToBounds=YES;
    
    [_segment4 setTintColor:[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]];
    
    
    _specialInstructionView.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _specialInstructionView.layer.borderWidth=2.0f;
    _specialInstructionView.layer.cornerRadius=8.0f;
    _specialInstructionView.layer.masksToBounds=YES;
    
    _savePrefernceBtn.layer.borderColor=[[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0]CGColor];
    _savePrefernceBtn.layer.borderWidth=2.0f;
    _savePrefernceBtn.layer.cornerRadius=8.0f;
    _savePrefernceBtn.layer.masksToBounds=YES;
    
    [self setupMenuBarButtonItems];

}

- (void)setupMenuBarButtonItems {
    self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(rightSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}


#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
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
