//
//  Popover_Passenger.m
//  BhutanAir
//
//  Created by Monika on 07/04/15.
//  Copyright (c) 2015 AMADEUS. All rights reserved.
//

#import "Popover_Passenger.h"
//#import "BookingSearchView.h"
//#import "traveler_info_View.h"

@interface Popover_Passenger ()

@end

@implementation Popover_Passenger
@synthesize alphaname;
@synthesize calltypeclass;
//@synthesize delegate_search;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select";
    //self.alphaname = [NSMutableArray arrayWithObjects:@"ALL",@"A-C", @"D-F", @"G-I",@"J-L", @"M-O", @"P-R",@"S-U", @"V-X", @"Y-1,2,3", nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.alphaname count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.alphaname objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if([self.delegate_search respondsToSelector:@selector(selectedTableRowpass:)])
//    {
//        [self.delegate_search selectedTableRowpass:indexPath.row];
//        
//        
//    }
//    if ([self.delegate_Traveler respondsToSelector:@selector(selectedTableRowpass:selectedval:)])
//    {
//        [self.delegate_Traveler selectedTableRowpass:indexPath.row selectedval:[self.alphaname objectAtIndex:indexPath.row]];
//    }
//    
//}


@end
