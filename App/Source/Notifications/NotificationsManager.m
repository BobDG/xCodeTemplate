//
//  NotificationsManager.m
//
//  Created by Bob de Graaf on 02-12-13.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "NotificationsManager.h"

@implementation NotificationsManager

#pragma mark Push Permission/Register methods

+(void)registerForNotificationsOnLaunch
{
    //Only register at launch if the question has already been asked
    if([nsprefs boolForKey:kPushPermissionAsked]) {
        [self registerForNotifications];
    }
}

+(void)registerForNotifications
{
    //DLog(@"Register using notification settings...");
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil]];
    [nsprefs setBool:TRUE forKey:kPushPermissionAsked];
    [nsprefs synchronize];
}

#pragma mark Push Delegate methods

+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	NSString *pushToken = [[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLog(@"Push token received, token: %@", pushToken);
}

+(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
	DLog(@"Fail PUSH: %@", [error description]);
   
}

+(void)didReceiveLocalNotification:(NSDictionary *)userInfo
{
    //DLog(@"Did receive local notification");
    //[self processNotificationMessage:userInfo];
}

+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //DLog(@"Did receive push notification");
    [self processNotificationMessage:userInfo];
}

+(void)processNotificationMessage:(NSDictionary *)notification
{
    DLog(@"Need to process notification message: %@", notification);
    
    //APS?
    if(!notification[@"aps"]) {
        DLog(@"Notification no APS found...");
        return;
    }
    
    //Alert?
    NSDictionary *apsDict = notification[@"aps"];
    if(!apsDict[@"alert"]) {
        DLog(@"Notification no alert text found");
        return;
    }
}

@end

































