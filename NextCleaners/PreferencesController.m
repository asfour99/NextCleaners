//
//  PreferencesController.m
//  NextCleaners
//
//  Created by Monika on 22/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "PreferencesController.h"

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
