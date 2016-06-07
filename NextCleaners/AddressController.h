//
//  AddressController.h
//  NextCleaners
//
//  Created by Monika on 02/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"
#import "APIHandler.h"



@interface AddressController : UIViewController<MBProgressHUDDelegate,InternetHandlerDelegate>
{
    IBOutlet MKMapView *mapView;
    
        CGFloat animatedDistance;
    

}
@property(retain,nonatomic) FPPopoverController *popover;
@property(retain,nonatomic)IBOutlet MKMapView *mapView;
@property(retain,nonatomic)MBProgressHUD *HUD;
@property(retain,nonatomic) NSString *userId;

-(void)selectedTableRow:(NSUInteger)rowNum;

@end
