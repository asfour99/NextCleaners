//
//  LoginController.h
//  NextCleaners
//
//  Created by Monika on 29/03/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"
#import "FVCustomAlertView.h"
#import "MBProgressHUD.h"

@interface LoginController : UIViewController<InternetHandlerDelegate,MBProgressHUDDelegate>
{
    CGFloat animatedDistance;
}
@property(retain,nonatomic)MBProgressHUD *HUD;

@end
