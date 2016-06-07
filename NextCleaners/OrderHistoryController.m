//
//  OrderHistoryController.m
//  NextCleaners
//
//  Created by Monika on 25/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "OrderHistoryController.h"
#import "MainViewController.h"
//#import "JDMenuViewController.h"
#import "MFSideMenu.h"


@interface OrderHistoryController ()

@end

@implementation OrderHistoryController
@synthesize mainTable;
@synthesize tableData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableData = [NSArray arrayWithObjects:@"May 26, 2016", @"May 23, 2016", @"May 13, 2016", @"April 23, 2016", @"April 20, 2016", @"April 10, 2016", @"April 05, 2016", nil];
    
     [self setupMenuBarButtonItems];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (indexPath.row%2==0)
    {
        cell.backgroundColor=[UIColor colorWithRed:235.0/255.0f green:228/255.0f blue:242/255.0f alpha:1.0];
    }
    else
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:107.0/255.0f green:61/255.0f blue:160/255.0f alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"montserrat-light" size:15];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
////    UIViewController *menuController = [[JDMenuViewController alloc] init];
////    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
////    
////    //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
////    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
////                                                          menuController:menuController];
////    [self.navigationController pushViewController:sideMenu animated:YES];
//
//    UIViewController *menuController = [[JDMenuViewController alloc] init];
//    MainViewController *mainVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    
//    //     UIViewController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    JDSideMenu *sideMenu = [[JDSideMenu alloc] initWithContentController:mainVC
//                                                          menuController:menuController];
//    [self.navigationController pushViewController:sideMenu animated:YES];
    
    
    
    
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ((touch.view == mainTable))
//    {
//        return NO;
//    }
//    return YES;
//}

- (void)setupMenuBarButtonItems {
    self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(rightSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(backButtonPressed:)];
}


#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
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
