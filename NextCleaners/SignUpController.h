//
//  SignUpController.h
//  NextCleaners
//
//  Created by Monika on 01/04/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIHandler.h"
#import "MBProgressHUD.h"
#import "FVCustomAlertView.h"


@interface SignUpController : UIViewController<InternetHandlerDelegate,MBProgressHUDDelegate>
{
    CGFloat animatedDistance;
}
@property(retain,nonatomic)MBProgressHUD *HUD;
@end
