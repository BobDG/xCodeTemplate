//
//  ErrorHandler.m
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "ErrorHandler.h"

@implementation ErrorHandler

+(void)handleError:(NSError *)error
{
    if([nsprefs boolForKey:kErrorUnauthorized]) {      
        showM1(NSLocalizedString(@"Error_Popup_API_SessionExpired", @""));
        //[CoreData deleteObjectsForEntity:[User entityName]];
        //[SVProgressHUD dismiss];
        //[kAppDelegate continueLaunchFlow];
        return;
    }
    
    NSString *message = NSLocalizedString(@"Error_Popup_API_General", @"");
    showM1(message);
}

+(void)handleLoginError:(NSError *)error
{
    NSString *message = NSLocalizedString(@"Error_Popup_API_General", @"");
    showM1(message);
}

@end
