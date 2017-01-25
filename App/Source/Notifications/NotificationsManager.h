//
//  NotificationsManager.h
//
//  Created by Bob de Graaf on 02-12-13.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPushPermissionAsked    @"kPushPermissionAsked"

@interface NotificationsManager : NSObject
{
    
}

+(void)registerForNotifications;
+(void)registerForNotificationsOnLaunch;
+(void)didReceiveLocalNotification:(NSDictionary *)userInfo;
+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
+(void)processNotificationMessage:(NSDictionary *)notification;
+(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

//Message
+(void)showMessage:(NSString *)message fromViewController:(UIViewController *)viewController;
+(void)showMessage:(NSString *)title message:(NSString *)message fromViewController:(UIViewController *)viewController;

@end
