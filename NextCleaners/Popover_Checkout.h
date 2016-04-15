//
//  Popover_Checkout.h
//  Koovs-Fashion
//
//  Created by Monika on 08/08/13.
//  Copyright (c) 2013 Koovs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressController.h"
@class AddressController;



@interface Popover_Checkout : UITableViewController
{
    NSMutableArray *alphaname;
    NSString *calltypeclass;   // tell from which class call comming
}
@property(nonatomic,assign) AddressController *delegate;
//@property(nonatomic,assign) BookingSearchView *delegate_search;
@property(retain,nonatomic) NSMutableArray *alphaname;
@property(retain,nonatomic) NSString *calltypeclass;

-(void)selectedTableRow:(NSUInteger)rowNum;
@end
