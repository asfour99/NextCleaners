//
//  CardDetailsController.m
//  NextCleaners
//
//  Created by Monika on 29/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "CardDetailsController.h"
#import "AddressController.h"
#import "APIKeys.h"



static const CGFloat KEYBOARD_ANIMATION_DURATION =0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@interface CardDetailsController ()
{
    int btnTapTag;
    
}
@property(nonatomic, strong, readwrite) IBOutlet CardIOView *cardIOView;

@property(weak,nonatomic)IBOutlet UITextField *cardNo_Field;
@property(weak,nonatomic)IBOutlet UITextField *cvc_Field;
@property(weak,nonatomic)IBOutlet UITextField *zipCode_Field;
//@property(weak,nonatomic)IBOutlet UITextField *lastName_Field;
//@property(weak,nonatomic)IBOutlet UITextField *phone_Field;
@property(weak,nonatomic)IBOutlet UIButton *monthBtn;
@property(weak,nonatomic)IBOutlet UIButton *yearBtn;
@property(weak,nonatomic)IBOutlet UIButton *cardBtn;
@property(weak,nonatomic)IBOutlet UIButton *nextBtn;
@property(weak,nonatomic)IBOutlet UIView *pickerMainView;
@property(weak,nonatomic)IBOutlet UIPickerView *mainPicker;

@end

@implementation CardDetailsController
@synthesize userId;
@synthesize monthArray;
@synthesize yearArray;
@synthesize HUD;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    if (![CardIOUtilities canReadCardWithCamera]) {
        // Hide your "Scan Card" button, remove the CardIOView from your view, and/or take other appropriate action...
    } else {
        self.cardIOView.delegate = self;
    }
    _pickerMainView.hidden=TRUE;
    self.monthArray=[[NSMutableArray alloc]initWithCapacity:0];
    self.yearArray=[[NSMutableArray alloc]initWithCapacity:0];

    self.navigationController.navigationBarHidden=TRUE;
    _cardNo_Field.layer.cornerRadius=8.0f;
    _cardNo_Field.layer.masksToBounds=YES;
    _cardNo_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _cardNo_Field.layer.borderWidth= 1.0f;
    UIColor *color = [UIColor whiteColor];
    _cardNo_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Card #" attributes:@{NSForegroundColorAttributeName: color}];
    _cardNo_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _cardNo_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _cardNo_Field.textColor=[UIColor whiteColor];
    
    _cvc_Field.layer.cornerRadius=8.0f;
    _cvc_Field.layer.masksToBounds=YES;
    _cvc_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _cvc_Field.layer.borderWidth= 1.0f;
    
    _cvc_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CVC" attributes:@{NSForegroundColorAttributeName: color}];
    _cvc_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _cvc_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _cvc_Field.textColor=[UIColor whiteColor];
    
    _zipCode_Field.layer.cornerRadius=8.0f;
    _zipCode_Field.layer.masksToBounds=YES;
    _zipCode_Field.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _zipCode_Field.layer.borderWidth= 1.0f;
    _zipCode_Field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip Code" attributes:@{NSForegroundColorAttributeName: color}];
    _zipCode_Field.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    _zipCode_Field.font=[UIFont fontWithName:@"montserrat-light.ttf" size:27];
    _zipCode_Field.textColor=[UIColor whiteColor];
    
    _monthBtn.layer.cornerRadius=8.0f;
    _monthBtn.layer.masksToBounds=YES;
    _monthBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _monthBtn.layer.borderWidth= 1.0f;
    
    _yearBtn.layer.cornerRadius=8.0f;
    _yearBtn.layer.masksToBounds=YES;
    _yearBtn.layer.borderColor=[[UIColor colorWithRed:122.0f/255.0f green:192.0f/255.0f blue:66.0f/255.0f alpha:1.0f]CGColor];
    _yearBtn.layer.borderWidth= 1.0f;
    
    for (int i=1; i<=12; i++)
    {
        [monthArray addObject:[NSString stringWithFormat:@"%2d",i]];
    }
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    // NSInteger day = [components day];
    // NSInteger month = [components month];
    NSInteger year = [components year];
    
    for (int j=0; j<83; j++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%ld",year+1]];
        year=year+1;
        
    }
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _cardNo_Field.inputAccessoryView = keyboardDoneButtonView;
    _cvc_Field.inputAccessoryView=keyboardDoneButtonView;
    _zipCode_Field.inputAccessoryView=keyboardDoneButtonView;


    [self ActivityBar];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}

- (IBAction)scanCard:(id)sender {
    self.cardIOView.hidden = NO;
}

- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)info {
    if (info) {
        // The full card number is available as info.cardNumber, but don't log that!
        NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
        _cardNo_Field.text=info.redactedCardNumber;
        [_monthBtn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth] forState:UIControlStateNormal];
        [_yearBtn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear] forState:UIControlStateNormal];
        _cvc_Field.text=info.cvv;
        // Use the card info...
    }
    else {
        NSLog(@"User canceled payment info");
        // Handle user cancellation here...
        NSString *errorMsg=@"Scanning Cancelled by user";
        
        CGFloat titlewidth=[self findwidth:errorMsg fonname:FONT_LIGHT fontsize:20];
        
        [FVCustomAlertView showDefaultErrorAlertOnView:self.view withTitle:errorMsg widthofview:titlewidth];
        [self performSelector:@selector(hideSuccessView) withObject:nil afterDelay:2.0];
        
    }
    
    cardIOView.hidden = YES;
}
- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
- (IBAction)cancelScanCard:(id)sender {
    self.cardIOView.hidden = YES;
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

-(IBAction)cancelBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)nextBtnPressed:(id)sender
{
    BOOL CARDNO_BOOL=FALSE;
    BOOL MONTH_BOOL=FALSE;
    BOOL YEAR_BOOL=FALSE;
    BOOL CVC_BOOL=FALSE;
    BOOL ZIP_BOOL=FALSE;
    
    if (_cardNo_Field.text.length==0)
    {
        CARDNO_BOOL=TRUE;
    }
    if ([_monthBtn.titleLabel.text isEqualToString:@"Month"])
    {
        MONTH_BOOL=TRUE;
    }
    if ([_yearBtn.titleLabel.text isEqualToString:@"Year"])
    {
        YEAR_BOOL=TRUE;
    }
    if (_cardNo_Field.text.length==0)
    {
        CVC_BOOL=TRUE;
    }
    if (_zipCode_Field.text.length==0)
    {
        ZIP_BOOL=TRUE;
    }

    if (CARDNO_BOOL==FALSE&&MONTH_BOOL==FALSE&&YEAR_BOOL==FALSE&&CVC_BOOL==FALSE&&ZIP_BOOL==FALSE)
    {
        [HUD show:YES];
        APIHandler *apiHandler = [[APIHandler alloc] init] ;
        apiHandler.delegate = self ;
        [apiHandler userCardDetailsApiCall:_cardNo_Field.text monthVal:_monthBtn.titleLabel.text yearVal:_yearBtn.titleLabel.text cvc:userId];
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
        AddressController *loginCon=[[AddressController alloc]initWithNibName:@"AddressController" bundle:nil];
            loginCon.userId=userId;
        [self.navigationController pushViewController:loginCon animated:YES];
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

    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//    [HUD hide:YES];
//    });
//    NSString *errorMsg=[NSString stringWithFormat:@"%@",errodesc];
//    UIAlertView *error=[[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [error show];
    
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

-(IBAction)datePickerAction:(id)sender
{
    [_cardNo_Field resignFirstResponder];
    [_cvc_Field resignFirstResponder];
    [_zipCode_Field resignFirstResponder];
    
    UIButton *senBtn=(UIButton*)sender;
    if (senBtn.tag==111)
    {
        btnTapTag=111;
    }
    else if (senBtn.tag==222)
    {
        btnTapTag=222;
    }
    else if (senBtn.tag==333)
    {
        btnTapTag=333;
    }
    
    
    if (_pickerMainView.hidden==TRUE)
    {
        _pickerMainView.hidden=FALSE;
        [_mainPicker reloadAllComponents] ;
    }
    else
    {
        _pickerMainView.hidden=TRUE;
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)personInfoPicker
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)personInfoPicker numberOfRowsInComponent: (NSInteger)component
{
    //    if (component == 0)
    //        return [heightsArray count];
    //    else if (component == 1)
    //        return [weightsArray count];
    //    else
    //return [timeArray count];
    if (btnTapTag==111)
    {
        return [monthArray count];
    }
    else if (btnTapTag==222)
    {
        return [yearArray count];
    }
    
    else
        return 0;
    
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (btnTapTag==111)
    {
        return [monthArray objectAtIndex:row];
    }
    else if (btnTapTag==222)
    {
        return [NSString stringWithFormat:@"%@",[yearArray objectAtIndex:row]] ;
    }
    
    else
        return @"Noval";
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (btnTapTag==111)
    {
        [_monthBtn setTitle:[monthArray objectAtIndex:row] forState:UIControlStateNormal];
    }
    else if (btnTapTag==222)
    {
        [_yearBtn setTitle:[NSString stringWithFormat:@"%@",[yearArray objectAtIndex:row]] forState:UIControlStateNormal];
    }
    
    
    
}

-(IBAction)pickerDoneBtnAction:(id)sender
{
    _pickerMainView.hidden=TRUE;
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
