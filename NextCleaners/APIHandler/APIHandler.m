//
//  APIHandler.m
//  NextCleaners
//
//  Created by Monika on 30/05/16.
//  Copyright © 2016 NextCleaners. All rights reserved.
//

#import "APIHandler.h"
#import "APIKeys.h"


@implementation APIHandler
@synthesize delegate;

-(void)loginApiCall:(NSString*)emailId password:(NSString*)passwordVal
{
//    NSString *post=[NSString stringWithFormat:@"{\"email\": \"%@\",\"password\": \"%@\",}",emailId,passwordVal];
    
    
    NSString *urlStr=MAIL_URL;
    urlStr=[urlStr stringByAppendingString:LOGIN_USER_URL];
    //urlStr=[urlStr stringByAppendingString:@"email:"];
    urlStr=[urlStr stringByAppendingString:emailId];
    urlStr=[urlStr stringByAppendingString:@"/"];
    urlStr=[urlStr stringByAppendingString:passwordVal];
    
    [self POSTAPICALL:@"" urlstr:urlStr methodType:@"GET"];

    
}

-(void)signUpApiCall:(NSString*)apiNameTag firstName:(NSString*)FName lastName:(NSString*)LName emailId:(NSString*)EMail phoneNum:(NSString*)PNo password:(NSString*)Password
{
    NSString *post=[NSString stringWithFormat:@"{\"FirstName\": \"%@\",\"LastName\": \"%@\",\"Gender\": \"Female\",\"FacebookId\":\"0\",\"Email\":\"%@\",\"Activation\":\"1\",\"ActivationCode\":\"123454\",\"ImageUrl\":\"\",\"IPAddress\":\"123454\",\"Mobile\":\"%@\",\"Password\":\"%@\",\"PaymentId\":\"1\",\"RoleId\":\"1\",\"StatusID\":\"1\",\"TypeId\":\"1\",}",FName,LName,EMail,PNo,Password];

    
    NSString *urlStr=MAIL_URL;
    urlStr=[urlStr stringByAppendingString:REGISTER_USER_URL];
    
    [self POSTAPICALL:post urlstr:urlStr methodType:@"POST"];
}

-(void)userCardDetailsApiCall:(NSString*)cardNo monthVal:(NSString*)MonthVal yearVal:(NSString*)YearVal cvc:(NSString*)CVCVal
{
    NSString *post=[NSString stringWithFormat:@"{\"UserId\": \"%@\",\"IsActive\": \"1\",\"Number\": \"%@\",\"ExpMonth\": \"%@\",\"ExpYear\": \"%@\",}",CVCVal,cardNo,MonthVal,YearVal];
    
    
    NSString *urlStr=MAIL_URL;
    urlStr=[urlStr stringByAppendingString:CARD_DETAILS_URL];
    
    [self POSTAPICALL:post urlstr:urlStr methodType:@"POST"];

}
-(void)addressApiCall:(NSString*)address Apt:(NSString*)address2Val CityVal:(NSString*)CityVal latVal:(NSString*)latVal longVal:(NSString*)longVal nameVal:(NSString*)nameVal useridVal:(NSString*)userIdVal zipVal:(NSString*)zipVal inspVal:(NSString*)insVal
{
    NSString *post=[NSString stringWithFormat:@"{\"Address\": \"%@\",\"Address2\": \"%@\",\"City\": \"%@\",\"Country\": \"New York\",\"Instructions\": \"%@\",\"IsSelected\": \"1\",\"Latitude\": \"%@\",\"Longitude\": \"%@\",\"Name\": \"%@\",\"State\": \"NY\",\"UserId\": \"%@\",\"Zip\": \"%@\",}",address,address2Val,CityVal,insVal,latVal,longVal,nameVal,userIdVal,zipVal];
    
    
    NSString *urlStr=MAIL_URL;
    urlStr=[urlStr stringByAppendingString:ADDRESS_USER_URL];
    
    [self POSTAPICALL:post urlstr:urlStr methodType:@"POST"];
    
}

-(void)POSTAPICALL:(NSString*)postDataStr urlstr:(NSString*)urlStr methodType:(NSString*)type
{
    NSURL *url=[NSURL URLWithString:urlStr];
    //NSString *jsonRequest = [ParamDictionary JSONRepresentation];
    NSData *postData = [postDataStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    
    [request setHTTPMethod:type];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //[request setValue:token forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,
                                                                                     
                                                                                     NSData *data, NSError *error)
     {
         
         if ([data length] >0 && error == nil)
             
         {
             
             NSDictionary* dicWholeValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             
             NSLog(@"%@",dicWholeValue);
             [delegate requestSucceded:self dicData:dicWholeValue];
             
         }
         
         else if ([data length] == 0 && error == nil)
             
         {
             
             NSLog(@"Nothing was downloaded.");
             [delegate requestFailed:self getval:@"Something went wrong"];
             
         }
         
         else if (error != nil)
             
         {
             
             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                 
                 
                 
                 //Do any updates to your label here
                 
                 NSLog(@"Error happened = %@", error);
                 [delegate requestFailed:self getval:[NSString stringWithFormat:@"%@",error]];
                 
                 
                 
             }];
             
             
             
         } }];

    
}




@end
