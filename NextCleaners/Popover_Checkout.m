//
//  Popover_Checkout.m
//  Koovs-Fashion
//
//  Created by Monika on 08/08/13.
//  Copyright (c) 2013 Koovs. All rights reserved.
//

#import "Popover_Checkout.h"

//#import "BookingSearchView.h"

@interface Popover_Checkout ()

@end

@implementation Popover_Checkout
@synthesize alphaname;
@synthesize calltypeclass;
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Select";
    if ([calltypeclass isEqualToString:@"111"])
    {
        self.alphaname = [NSMutableArray arrayWithObjects:@"INDIVIDUAL",@"BUISNESS", @"HOTEL", @"RETAIL", nil];
    }
   else if ([calltypeclass isEqualToString:@"222"])
    {
        self.alphaname = [NSMutableArray arrayWithObjects:@"DOORMAN",@"NODOORMAN", nil];
    }

    
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(selectedTableRow:)])
    {
        [self.delegate selectedTableRow:indexPath.row];
    }
//    if ([self.delegate_search respondsToSelector:@selector(selectedTableRow:)])
//    {
//        [self.delegate_search selectedTableRow:indexPath.row];
//
//    }
}


@end
