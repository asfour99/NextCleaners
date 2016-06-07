//
//  CardDetailsController.h
//  NextCleaners
//
//  Created by Monika on 29/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"
#import "MBProgressHUD.h"
#import "FVCustomAlertView.h"
#import "CardIO.h"

@interface CardDetailsController : UIViewController<InternetHandlerDelegate,MBProgressHUDDelegate,CardIOViewDelegate>
{
    CGFloat animatedDistance;
    NSString *userId;
}
@property(retain,nonatomic) NSString *userId;
@property (retain,nonatomic) NSMutableArray *monthArray;
@property (retain,nonatomic) NSMutableArray *yearArray;
@property(retain,nonatomic)MBProgressHUD *HUD;


@end
