//
//  AddressController.m
//  NextCleaners
//
//  Created by Monika on 02/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "AddressController.h"
#import "Popover_Checkout.h"
#import "JDMenuViewController.h"
#import "JDSideMenu.h"
#import "MainViewController.h"
#import "APIHandler.h"
#import "FVCustomAlertView.h"
#import "APIKeys.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+RoudedCorners.h"
#import "TRAutocompleteView.h"
#import "TRGoogleMapsAutocompleteItemsSource.h"
#import "TRTextFieldExtensions.h"
#import "TRGoogleMapsAutocompletionCellFactory.h"
#import "AppDelegate.h"
static const CGFloat KEYBOARD_ANIMATION_DURATION =0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;


@interface AddressController ()
{
     __weak IBOutlet UITextField *_address_Field;
     TRAutocompleteView *_autocompleteView;
}
@property(retain,nonatomic)IBOutlet UIButton *locationTypeBtn;
@property(retain,nonatomic)IBOutlet UIButton *doormanTypeBtn;
//@property(weak,nonatomic)IBOutlet UITextField *address_Field;
//@property(retain,nonatomic)IBOutlet UITextField *cardNo_Field;
@property(retain,nonatomic)IBOutlet UITextField *apartment_Field;
@property(retain,nonatomic)IBOutlet UITextField *zipCode_Field;
@property(retain,nonatomic)IBOutlet UITextView *note_txtView;
@property(retain,nonatomic) NSString *classType;
@property(retain,nonatomic) IBOutlet UIView *popupView;
@property(retain,nonatomic) IBOutlet UITableView *POPUPTBL;


@end

@implementation AddressController
@synthesize popover;
@synthesize mapView;
@synthesize HUD;
@synthesize userId;

- (void)loadView
{
    [super loadView];
    _autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:_address_Field
                                                         usingSource:[[TRGoogleMapsAutocompleteItemsSource alloc]
                                                                      initWithMinimumCharactersToTrigger:2
                                                                      apiKey:@"AIzaSyCR7zg8hGrWPCecIp82qUHijminUSGJPU8"]
                                                         cellFactory:[[TRGoogleMapsAutocompletionCellFactory alloc]
                                                                      initWithCellForegroundColor:[UIColor lightGrayColor]
                                                                      fontSize:14]
                                                        presentingIn:self];
    _autocompleteView.topMargin = -5;
    _autocompleteView.backgroundColor = [UIColor colorWithRed:(27) / 255.0f
                                                        green:(27) / 255.0f
                                                         blue:(27) / 255.0f
                                                        alpha:1];
    __weak typeof(self) weakSelf = self;
    _autocompleteView.didAutocompleteWith = ^(id<TRSuggestionItem> item)
    {
        NSLog(@"Autocompleted with: %@", item.completionText);
        [weakSelf setLocationonmap:item.completionText];
    };
    

}

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
    _address_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:15];
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
    
//    _popupView.layer.cornerRadius=8.0f;
    _popupView.layer.masksToBounds=YES;
//    _popupView.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
//    _popupView.layer.borderWidth= 1.0f;
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_popupView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(8.0, 8.0)];
//    
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.view.bounds;
//    maskLayer.path  = maskPath.CGPath;
//    _popupView.layer.mask = maskLayer;
//
//    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
//    borderLayer.frame = self.view.bounds;
//    borderLayer.path  = maskPath.CGPath;
//    borderLayer.lineWidth   = 1.0f;
//    borderLayer.strokeColor = [[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
//    borderLayer.fillColor   = [UIColor clearColor].CGColor;
//    
//    [_popupView.layer addSublayer:borderLayer];
//
    //[_popupView setRoundedCorners:UIRectCornerAllCorners radius:8.0];
    
    
    [_popupView setRoundedCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight radius:8.0];


    
    _POPUPTBL.separatorInset = UIEdgeInsetsZero;
    _POPUPTBL.layoutMargins = UIEdgeInsetsZero;
    
    
    
   
    _classType=@"000";
    
    
    
    [self ActivityBar];
}
-(void)setLocationonmap:(NSString*)addstr
{
    
    NSString *stringAdress = [addstr stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *esc_addr =  [stringAdress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    
    if (dataArray.count == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter a valid address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"geometry"];
            NSMutableArray *Location = [jsonStr1 valueForKey:@"location"];
            NSString *latitude = [Location  valueForKey:@"lat"];
            NSString *longitude = [Location  valueForKey:@"long"];
            NSLog(@"Data Return %@",latitude);
            NSLog(@"Data Returnlong %@",longitude);
            // self.automaticallyAdjustsScrollViewInsets = NO;
            // Do any additional setup after loading the view from its nib.
            // add map view annotation and zoom
            float spanX = 0.0325;
            float spanY = 0.0325;
            MKCoordinateRegion region;
            //region.center.latitude = 28.484979;//self.mapView.userLocation.coordinate.latitude;
            //region.center.longitude =77.063421; //self.mapView.userLocation.coordinate.longitude;
            region.center.latitude = [latitude doubleValue];
            region.center.longitude = [longitude doubleValue];
            //self.mapView.userLocation.coordinate.latitude;
            //region.center.longitude =77.063421; //self.mapView.userLocation.coordinate.longitude;
            
            region.span.latitudeDelta = spanX;
            region.span.longitudeDelta = spanY;
            [self.mapView setRegion:region animated:YES];
            
            
            CLLocationCoordinate2D annotationCoord;
            
//            annotationCoord.latitude = 28.484979;
//            annotationCoord.longitude = 77.063421;
            annotationCoord.latitude = [latitude doubleValue];;
            annotationCoord.longitude = [longitude doubleValue];
            
            MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
            annotationPoint.coordinate = annotationCoord;
            //annotationPoint.title = @"Marble E-Retail Pvt. Ltd.";
            //annotationPoint.subtitle = @"75D, Gate No-2,Sector-18 Gurgaon, Haryana - 122015";
            annotationPoint.title = @"";
            annotationPoint.subtitle = addstr;
            [mapView addAnnotation:annotationPoint];
            
            //    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
            //    rotateGesture.delegate=self;
            
            //[mapView addGestureRecognizer:rotateGesture];

            
            
        }
    }
    
//    NSString *URLString = [NSString stringWithFormat:@"http://ws.geonames.org/findNearbyPostalCodesJSON?formatted=true&lat=36&lng=-79.08"];
//    NSURL *url = [NSURL URLWithString:URLString];
//    [AppDelegate downloadDataFromURL:url withCompletionHandler:^(NSData *data) {
//        // Check if any data returned.
//      //  NSString *error=@"";
//        if (data != nil) {
//            NSLog(@"%@", [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] class]);
//        }
//    }];
    
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.2];
    
    [UIView commitAnimations];
    //    NSString *dateStr = [df stringFromDate:datePciker.date];
    //    NSLog(@"datestring== %@",dateStr);
    
    
    CGRect textFieldRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
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

- (void)textViewDidEndEditing:(UITextView *)textView
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
-(IBAction)nextBtnPressed:(id)sender

{
    BOOL LOCATION_BOOL=FALSE;
    BOOL DOOREMAN_BOOL=FALSE;
    BOOL ADDRESS_BOOL=FALSE;
    BOOL APARTMENT_BOOL=FALSE;
    BOOL ZIPCODE_BOOL=FALSE;
    BOOL INSTRUCTIONS_BOOL=FALSE;
    if (_locationTypeBtn.titleLabel.text.length==0)
    {
        LOCATION_BOOL=TRUE;
    }
    if (_doormanTypeBtn.titleLabel.text.length==0)
    {
        DOOREMAN_BOOL=TRUE;
    }
    if (_address_Field.text.length==0)
    {
        ADDRESS_BOOL=TRUE;
    }
    if (_apartment_Field.text.length==0)
    {
        APARTMENT_BOOL=TRUE;
    }
    if (_zipCode_Field.text.length==0)
    {
        ZIPCODE_BOOL=TRUE;
    }
    if (_note_txtView.text.length==0)
    {
        INSTRUCTIONS_BOOL=TRUE;
    }
    
    if (LOCATION_BOOL==FALSE&& DOOREMAN_BOOL==FALSE&&ADDRESS_BOOL==FALSE&&APARTMENT_BOOL==FALSE&&ZIPCODE_BOOL==FALSE&&INSTRUCTIONS_BOOL==FALSE)
    {
        
        [HUD show:YES];
        APIHandler *apiHandler = [[APIHandler alloc] init] ;
        apiHandler.delegate = self ;
        [apiHandler addressApiCall:_address_Field.text Apt:_apartment_Field.text CityVal:@"New York" latVal:@"40.724787" longVal:@"-73.986900" nameVal:@"" useridVal:userId zipVal:_zipCode_Field.text inspVal:_note_txtView.text];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD hide:YES];
            
            CGFloat titlewidth=[self findwidth:@"Please check all fields" fonname:FONT_LIGHT fontsize:20];
            
            [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:@"Please check all fields" widthofview:titlewidth];
            [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
        });
        
    }
    

    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    if ([text length] == 1 && resultRange.location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(CGFloat)findwidth:(NSString *)textname fonname:(NSString*)fontname fontsize:(float)fontsize
{
    return  ceil([textname sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:fontname size:fontsize]}].width);
}
-(void)hideSuccessView
{
    [FVCustomAlertView hideAlertFromView:self.view fading:YES];
    
}
-(void)requestSucceded:(id)sender dicData:(NSDictionary *)apiData
{
    NSString *successTag=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"success"]];
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //    [HUD hide:YES];
    //    });
    
    if ([successTag isEqualToString:@"1"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD hide:YES];
            UIViewController *menuController = [[JDMenuViewController alloc] init];
            MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            
            //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
            JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
                                                                  menuController:menuController];
            [self.navigationController pushViewController:sideMenu animated:YES];

        });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [HUD hide:YES];
            NSString *errorMsg=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"message"]];
            
            CGFloat titlewidth=[self findwidth:errorMsg fonname:FONT_LIGHT fontsize:20];
            
            [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:errorMsg widthofview:titlewidth];
            [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
        });
        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //        NSString *errorMsg=[NSString stringWithFormat:@"%@",[apiData objectForKey:@"message"]];
        //        UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //        [error show];
        //        });
        
    }
    
    
    
}
-(void)requestFailed:(id)sender getval:(NSString*)errodesc
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [HUD hide:YES];
        NSString *errorMsg=[NSString stringWithFormat:@"%@",errodesc];
        
        CGFloat titlewidth=[self findwidth:errorMsg fonname:FONT_LIGHT fontsize:20];
        
        [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:errorMsg widthofview:titlewidth];
        [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
    });
}

- (IBAction)ddMenuShow:(UIButton *)sender
{
    if (sender.tag == 0) {
        sender.tag = 1;
        _popupView.hidden = NO;
        NSString *val=sender.titleLabel.text;
        //[sender setTitle:@"▲" forState:UIControlStateNormal];
        [sender setTitle:val forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"UPTriangleGreenActive.png"] forState:UIControlStateNormal];
        sender.backgroundColor=[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
    } else {
        sender.tag = 0;
        _popupView.hidden = YES;
         NSString *val=sender.titleLabel.text;
        //[sender setTitle:@"▼" forState:UIControlStateNormal];
        [sender setTitle:val forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"DTriangleGreenInactive.png"] forState:UIControlStateNormal];
        sender.backgroundColor=[UIColor clearColor];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
//    if (indexPath.row%2==0)
//    {
       cell.backgroundColor=[UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
//    }
//    else
//    {
//        cell.backgroundColor=[UIColor whiteColor];
//    }
    
               if (indexPath.row==0)
                {
                    //[_busissTypeBtn setTitle:@"INDIVIDUAL" forState:UIControlStateNormal];
                    cell.textLabel.text=@"INDIVIDUAL";
                }
                 else  if (indexPath.row==1)
                 {
                     //[_busissTypeBtn setTitle:@"BUISNESS" forState:UIControlStateNormal];
                     cell.textLabel.text=@"BUISNESS";
                 }
                 else  if (indexPath.row==2)
                 {
                     //[_busissTypeBtn setTitle:@"HOTEL" forState:UIControlStateNormal];
                     cell.textLabel.text=@"HOTEL";
                 }
                 else  if (indexPath.row==3)
                 {
                    // [_busissTypeBtn setTitle:@"RETAIL" forState:UIControlStateNormal];
                     cell.textLabel.text=@"RETAIL";
                 }

    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"montserrat-light" size:15];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *LOCVAL=@"";
    if (indexPath.row==0)
    {
        //[_busissTypeBtn setTitle:@"INDIVIDUAL" forState:UIControlStateNormal];
        LOCVAL=@"INDIVIDUAL";
    }
    else  if (indexPath.row==1)
    {
        //[_busissTypeBtn setTitle:@"BUISNESS" forState:UIControlStateNormal];
        LOCVAL=@"BUISNESS";
    }
    else  if (indexPath.row==2)
    {
        //[_busissTypeBtn setTitle:@"HOTEL" forState:UIControlStateNormal];
        LOCVAL=@"HOTEL";
    }
    else  if (indexPath.row==3)
    {
        // [_busissTypeBtn setTitle:@"RETAIL" forState:UIControlStateNormal];
        LOCVAL=@"RETAIL";
    }

    [_locationTypeBtn setTitle:LOCVAL forState:UIControlStateNormal];
    [_locationTypeBtn setImage:[UIImage imageNamed:@"DTriangleGreenInactive.png"] forState:UIControlStateNormal];
    _locationTypeBtn.backgroundColor=[UIColor clearColor];
    _locationTypeBtn.tag=0;
    _popupView.hidden=TRUE;

}



//- (IBAction)ddMenuSelectionMade:(UIButton *)sender;


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
