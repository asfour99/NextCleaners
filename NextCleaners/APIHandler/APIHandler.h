//
//  APIHandler.h
//  NextCleaners
//
//  Created by Monika on 30/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol InternetHandlerDelegate <NSObject>
@optional

-(void)requestSucceded:(id)sender dicData:(NSDictionary*)apiData;
-(void)requestFailed:(id)sender getval:(NSString*)errodesc;



@end

@interface APIHandler : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
@property(nonatomic,retain)id <InternetHandlerDelegate> delegate;
-(void)signUpApiCall:(NSString*)apiNameTag firstName:(NSString*)FName lastName:(NSString*)LName emailId:(NSString*)EMail phoneNum:(NSString*)PNo password:(NSString*)Password
;

-(void)userCardDetailsApiCall:(NSString*)cardNo monthVal:(NSString*)MonthVal yearVal:(NSString*)YearVal cvc:(NSString*)CVCVal;
-(void)loginApiCall:(NSString*)emailId password:(NSString*)passwordVal;
-(void)addressApiCall:(NSString*)address Apt:(NSString*)AptVal CityVal:(NSString*)CityVal latVal:(NSString*)latVal longVal:(NSString*)longVal nameVal:(NSString*)nameVal useridVal:(NSString*)userIdVal zipVal:(NSString*)zipVal  inspVal:(NSString*)insVal;




@end
