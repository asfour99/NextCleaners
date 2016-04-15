//
//  AddressController.m
//  NextCleaners
//
//  Created by Monika on 02/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "AddressController.h"
#import "Popover_Checkout.h"


@interface AddressController ()
@property(retain,nonatomic)IBOutlet UIButton *busissTypeBtn;
@property(retain,nonatomic)IBOutlet UIButton *doormanTypeBtn;
@property(retain,nonatomic) NSString *classType;

@end

@implementation AddressController
@synthesize popover;
@synthesize mapView;

- (void)viewDidLoad {
    self.navigationController.navigationBarHidden=FALSE;
    [super viewDidLoad];
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
    
    if ([_classType isEqualToString:@"111"])
    {
        if (rowNum==0)
        {
            [_busissTypeBtn setTitle:@"INDIVIDUAL" forState:UIControlStateNormal];
        }
         else if (rowNum==1)
         {
             [_busissTypeBtn setTitle:@"BUISNESS" forState:UIControlStateNormal];
         }
         else if (rowNum==2)
         {
             [_busissTypeBtn setTitle:@"HOTEL" forState:UIControlStateNormal];
         }
         else if (rowNum==3)
         {
             [_busissTypeBtn setTitle:@"RETAIL" forState:UIControlStateNormal];
         }
        
    }
    else if ([_classType isEqualToString:@"222"])
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
