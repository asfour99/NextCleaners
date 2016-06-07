//
//  OrderHistoryController.h
//  NextCleaners
//
//  Created by Monika on 25/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHistoryController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(retain,nonatomic) NSArray *tableData;
@property(retain,nonatomic) IBOutlet UITableView *mainTable;

@end
