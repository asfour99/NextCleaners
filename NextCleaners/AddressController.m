//
//  AddressController.m
//  NextCleaners
//
//  Created by Monika on 02/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "AddressController.h"
#import "Popover_Checkout.h"
static const CGFloat KEYBOARD_ANIMATION_DURATION =0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;


@interface AddressController ()
@property(retain,nonatomic)IBOutlet UIButton *locationTypeBtn;
@property(retain,nonatomic)IBOutlet UIButton *doormanTypeBtn;
@property(retain,nonatomic)IBOutlet UITextField *address_Field;
//@property(retain,nonatomic)IBOutlet UITextField *cardNo_Field;
@property(retain,nonatomic)IBOutlet UITextField *apartment_Field;
@property(retain,nonatomic)IBOutlet UITextField *zipCode_Field;
@property(retain,nonatomic)IBOutlet UITextView *note_txtView;
@property(retain,nonatomic) NSString *classType;

@end

@implementation AddressController
@synthesize popover;
@synthesize mapView;

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden=TRUE;
    [super viewDidLoad];
    
    
    UIColor *color = [UIColor whiteColor];
    _locationTypeBtn.layer.cornerRadius=8.0f;
    _locationTypeBtn.layer.masksToBounds=YES;
    _locationTypeBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _locationTypeBtn.layer.borderWidth= 1.0f;
    
    _doormanTypeBtn.layer.cornerRadius=8.0f;
    _doormanTypeBtn.layer.masksToBounds=YES;
    _doormanTypeBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _doormanTypeBtn.layer.borderWidth= 1.0f;
    
    _address_Field.layer.cornerRadius=8.0f;
    _address_Field.layer.masksToBounds=YES;
    _address_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _address_Field.layer.borderWidth= 1.0f;
    _address_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: color}];
    _address_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _address_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _address_Field.textColor=[UIColor whiteColor];
    
    _apartment_Field.layer.cornerRadius=8.0f;
    _apartment_Field.layer.masksToBounds=YES;
    _apartment_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _apartment_Field.layer.borderWidth= 1.0f;
    _apartment_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Apt" attributes:@{NSForegroundColorAttributeName: color}];
    _apartment_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _apartment_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _apartment_Field.textColor=[UIColor whiteColor];
    
    _zipCode_Field.layer.cornerRadius=8.0f;
    _zipCode_Field.layer.masksToBounds=YES;
    _zipCode_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _zipCode_Field.layer.borderWidth= 1.0f;
    _zipCode_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip Code" attributes:@{NSForegroundColorAttributeName: color}];
    _zipCode_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _zipCode_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _zipCode_Field.textColor=[UIColor whiteColor];
    
    _note_txtView.layer.cornerRadius=8.0f;
    _note_txtView.layer.masksToBounds=YES;
    _note_txtView.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _note_txtView.layer.borderWidth= 1.0f;
    
    
    
    
    


    
    
    
    
   // self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view from its nib.
    // add map view annotation and zoom
    float spanX = 0.0325;
    float spanY = 0.0325;
    MKCoordinateRegion region;
    region.center.latitude = 28.484979;//self.mapView.userLocation.coordinate.latitude;
    region.center.longitude =77.063421; //self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
    
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = 28.484979;
    annotationCoord.longitude = 77.063421;
    
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = annotationCoord;
    annotationPoint.title = @"Marble E-Retail Pvt. Ltd.";
    annotationPoint.subtitle = @"75D, Gate No-2,Sector-18 Gurgaon, Haryana - 122015";
    [mapView addAnnotation:annotationPoint];
    
//    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
//    rotateGesture.delegate=self;
    
    //[mapView addGestureRecognizer:rotateGesture];

    _classType=@"000";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)despopover:(id)sender
{
    ////NSLog(@"popover retain count: %d",[popover retainCount]);
    
    SAFE_ARC_RELEASE(popover); popover=nil;
   
    //the controller we want to present as a popover
    Popover_Checkout *controller = [[Popover_Checkout alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    controller.calltypeclass=@"111";
    _classType=@"111";
    //NSArray *allkey=[_origindata_dic allKeys];
    
//    [controller.alphaname addObject:@"INDIVIDUAL"];
//    [controller.alphaname addObject:@"BUISNESS"];
//    [controller.alphaname addObject:@"HOTEL"];
//    [controller.alphaname addObject:@"RETAIL"];
    
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    popover.tint = FPPopoverDefaultTint;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(250, 400);
    }
    else
    {
        popover.contentSize = CGSizeMake(200,270);
    }
    
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:sender];
    //}
    
}
-(IBAction)servicetypepopover:(id)sender
{
    ////NSLog(@"popover retain count: %d",[popover retainCount]);
    
    SAFE_ARC_RELEASE(popover); popover=nil;
    
    //the controller we want to present as a popover
    Popover_Checkout *controller = [[Popover_Checkout alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    controller.calltypeclass=@"222";
    _classType=@"222";
    //NSArray *allkey=[_origindata_dic allKeys];
    
//    [controller.alphaname addObject:@"DOORMAN"];
//    [controller.alphaname addObject:@"NODOORMAN"];
    
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    popover.tint = FPPopoverDefaultTint;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(250, 200);
    }
    else
    {
        popover.contentSize = CGSizeMake(200,270);
    }
    
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    [popover presentPopoverFromView:sender];
    //}
    
}


-(void)selectedTableRow:(NSUInteger)rowNum
{
    [popover dismissPopoverAnimated:YES];
    
//    if ([_classType isEqualToString:@"111"])
//    {
//        if (rowNum==0)
//        {
//            [_busissTypeBtn setTitle:@"INDIVIDUAL" forState:UIControlStateNormal];
//        }
//         else if (rowNum==1)
//         {
//             [_busissTypeBtn setTitle:@"BUISNESS" forState:UIControlStateNormal];
//         }
//         else if (rowNum==2)
//         {
//             [_busissTypeBtn setTitle:@"HOTEL" forState:UIControlStateNormal];
//         }
//         else if (rowNum==3)
//         {
//             [_busissTypeBtn setTitle:@"RETAIL" forState:UIControlStateNormal];
//         }
//        
//    }
    if ([_classType isEqualToString:@"222"])
    {
        if (rowNum==0)
        {
            [_doormanTypeBtn setTitle:@"DOORMAN" forState:UIControlStateNormal];
        }
        else if (rowNum==1)
        {
            [_doormanTypeBtn setTitle:@"NODOORMAN" forState:UIControlStateNormal];
        }

    }
    
     NSLog(@"selected row =%lu",(unsigned long)rowNum);
    
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



-(IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
