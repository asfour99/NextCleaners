//
//  WelcomeController.h
//  NextCleaners
//
//  Created by Monika on 29/03/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "APIHandler.h"

@interface WelcomeController : UIViewController<InternetHandlerDelegate>
{
    MPMoviePlayerViewController *playercontroller ;
}
//@property(retain,nonatomic)MPMoviePlayerViewController *playercontroller ;

@end
