//
//  ErrorHandler.m
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "ErrorHandler.h"

@implementation ErrorHandler

+(void)handleError:(NSError *)error fromViewController:(UIViewController *)viewController
{
    if([nsprefs boolForKey:kErrorUnauthorized]) {      
        NSString *message = NSLocalizedString(@"Error_Popup_API_SessionExpired", @"");
        [NotificationsManager showMessage:message fromViewController:viewController];
        //[CoreData deleteObjectsForEntity:[User entityName]];
        //[SVProgressHUD dismiss];
        //[kAppDelegate continueLaunchFlow];
        return;
    }
    
    NSString *message = NSLocalizedString(@"Error_Popup_API_General", @"");
    [NotificationsManager showMessage:message fromViewController:viewController];
}

+(void)handleLoginError:(NSError *)error fromViewController:(UIViewController *)viewController
{
    NSString *message = NSLocalizedString(@"Error_Popup_API_General", @"");
    [NotificationsManager showMessage:message fromViewController:viewController];
}

@end
