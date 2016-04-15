//
//  Popover_Passenger.h
//  BhutanAir
//
//  Created by Monika on 07/04/15.
//  Copyright (c) 2015 AMADEUS. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BookingSearchView.h"
//#import "traveler_info_View.h"
@class BookingSearchView;
@class traveler_info_View;

@interface Popover_Passenger : UITableViewController
{
NSMutableArray *alphaname;
NSString *calltypeclass;   // tell from which class call comming
}

@property(nonatomic,assign) BookingSearchView *delegate_search;
@property(nonatomic,assign) traveler_info_View *delegate_Traveler;

@property(retain,nonatomic) NSMutableArray *alphaname;
@property(retain,nonatomic) NSString *calltypeclass;


@end
