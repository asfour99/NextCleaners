//
//  JDMenuViewController.m
//  JDSideMenu
//
//  Created by Markus Emrich on 11.11.13.
//  Copyright (c) 2013 Markus Emrich. All rights reserved.
//

#import "UIViewController+JDSideMenu.h"

#import "JDMenuViewController.h"
#import "MainViewController.h"
#import "JDMenuTableCell.h"

@interface JDMenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menutableView;
@property(retain,nonatomic) NSMutableArray *menuItems;
@property(retain,nonatomic) NSMutableArray *menuItemsImageArray;


- (IBAction)switchController:(id)sender;
@end

@implementation JDMenuViewController

//-(void)loadView
//{
//    [super viewDidLoad];
//    
////    [_menuItems addObject:@"Order"];
////    [_menuItems addObject:@"Account"];
////    [_menuItems addObject:@"History"];
////    [_menuItems addObject:@"Promotions"];
////    [_menuItems addObject:@"Pricing"];
////    [_menuItems addObject:@"FAQ"];
////    [_menuItems addObject:@"Support"];
////    
////    [_menuItemsImageArray addObject:@"MyOrder.png"];
////    [_menuItemsImageArray addObject:@"My_Account.png"];
////    [_menuItemsImageArray addObject:@"History.png"];
////    [_menuItemsImageArray addObject:@"Promotions.png"];
////    [_menuItemsImageArray addObject:@"Pricing.png"];
////    [_menuItemsImageArray addObject:@"FAQ.png"];
////    [_menuItemsImageArray addObject:@"Support.png"];
//
//    
//}
- (void)viewDidLayoutSubviews;
{
    
   
    [super viewDidLayoutSubviews];
   
    

    //self.scrollView.contentSize = CGRectInset(self.scrollView.bounds, 0, -1).size;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath   *)indexPath
{
    return 62;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    JDMenuTableCell  *cell = (JDMenuTableCell  *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        NSArray* toplavelObjects = [[NSBundle mainBundle] loadNibNamed:@"JDMenuTableCell" owner:nil options:nil];
        
        for (id currentobject in toplavelObjects)
        {
            if ([currentobject isKindOfClass:[UITableViewCell class]])
            {
                cell = (JDMenuTableCell *)currentobject;
                //                cell.accessoryType=UITableViewCellAccessoryNone;
                //                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                break;
            }
        }
    }
    if (indexPath.row==0)
    {
        cell.menuItemLbl.text=@"Order";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"Order.png"]];
    }
    else if (indexPath.row==1)
    {
        cell.menuItemLbl.text=@"Account";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"My_Account.png"]];
    }
    else if (indexPath.row==2)
    {
        cell.menuItemLbl.text=@"History";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"History.png"]];
    }
    else if (indexPath.row==3)
    {
        cell.menuItemLbl.text=@"Promotions";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"Promotions.png"]];
    }
    else if (indexPath.row==4)
    {
        cell.menuItemLbl.text=@"Pricing";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"Pricing.png"]];
    }
    else if (indexPath.row==5)
    {
        cell.menuItemLbl.text=@"FAQ";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"FAQ.png"]];
    }
    else if (indexPath.row==6)
    {
        cell.menuItemLbl.text=@"Support";
        [cell.menuItemImage setImage:[UIImage imageNamed:@"Support.png"]];
    }


    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomHue = (arc4random()%256/256.0);
    MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    viewController.view.backgroundColor = [UIColor colorWithHue:randomHue saturation:1.0 brightness:1.0 alpha:1.0];
    viewController.title = [NSString stringWithFormat: @"Hue: %.2f", randomHue];
    
    //    UIViewController *contentController = [[UINavigationController alloc]
    //                                           initWithRootViewController:viewController];
    [self.sideMenuController setContentController:viewController animated:YES];
}



- (IBAction)switchController:(id)sender;
{
    CGFloat randomHue = (arc4random()%256/256.0);
    MainViewController *viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    viewController.view.backgroundColor = [UIColor colorWithHue:randomHue saturation:1.0 brightness:1.0 alpha:1.0];
    viewController.title = [NSString stringWithFormat: @"Hue: %.2f", randomHue];
    
//    UIViewController *contentController = [[UINavigationController alloc]
//                                           initWithRootViewController:viewController];
    [self.sideMenuController setContentController:viewController animated:YES];
}

@end
