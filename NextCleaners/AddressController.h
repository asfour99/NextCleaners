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


@interface AddressController : UIViewController
{
    IBOutlet MKMapView *mapView;

}
@property(retain,nonatomic) FPPopoverController *popover;
@property(retain,nonatomic)IBOutlet MKMapView *mapView;

-(void)selectedTableRow:(NSUInteger)rowNum;

@end
