//
//  AppDelegate.m
//
//  Created by Bob de Graaf on 02-01-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "AppDelegate.h"
#import "BDGScreenshot.h"
#import "NotificationsManager.h"
#import "DTTJailbreakDetection.h"

@interface AppDelegate ()
{
    
}

@property(nonatomic,strong) UIImageView *screenshotForMultitaskingImageView;

@end

@implementation AppDelegate

#pragma mark Application Launch

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Check jailbreak
    if([DTTJailbreakDetection isJailbroken]) {
        showM2(NSLocalizedString(@"Let op", @""), NSLocalizedString(@"Uw apparaat is gejailbreakt.\nWij staan niet in voor de veiligheid van opgeslagen gegevens.", @""));
    }
    
    //Data protection
    #warning Based on App Privacy -> Turn on Data Protection in Target Capabilities
    
    //Appearance
    [AppAppearance setupAppearance];
    
    //Data
    [AppData setupAppData];
    
    //Register for notifications
    [NotificationsManager registerForNotificationsOnLaunch];
    
    //Launch Flow
    [self continueLaunchFlow];
    
    return YES;
}

#pragma mark - Launch Flow

-(void)continueLaunchFlow
{
    
}

#pragma mark RootViewController animated

-(void)setRootViewController:(UIViewController *)viewController animated:(BOOL)animated
{    
    if(!animated) {
        self.window.rootViewController = viewController;
        return;
    }
    
    //Get screenshot
    UIImage *screenshot = [BDGScreenshot screenshotFromView:self.window];
    UIImageView *screenshotIV = [[UIImageView alloc] initWithImage:screenshot];
    
    //Set new controller
    self.window.rootViewController = viewController;
    
    //Add screenshot imageview
    [self.window addSubview:screenshotIV];
    
    //Scale transform
    viewController.view.transform = CGAffineTransformMakeScale(0.7f, 0.7f);
    
    //Animate Imageview
    [UIView animateWithDuration:0.4f animations:^{
        //screenshotIV.alpha = 0.0f;
        viewController.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        screenshotIV.transform = CGAffineTransformMakeTranslation(0, screenshotIV.frame.size.height);
    } completion:^(BOOL finished) {
        if(finished) {
            [screenshotIV removeFromSuperview];
        }
    }];
}

#pragma mark - Multitasking Screenshot

-(void)addMultitaskingScreenshot
{
    //Take screenshot
    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, NO, 0.0f);
    [self.window drawViewHierarchyInRect:self.window.bounds afterScreenUpdates:NO];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Create screenshot
    self.screenshotForMultitaskingImageView = [[UIImageView alloc] initWithImage:screenshotImage];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    blurView.frame = self.screenshotForMultitaskingImageView.bounds;
    [self.screenshotForMultitaskingImageView addSubview:blurView];
    [self.window addSubview:self.screenshotForMultitaskingImageView];
}

-(void)removeMultitaskingScreenshot
{
    //Sanity checks
    if(!self.screenshotForMultitaskingImageView || !self.screenshotForMultitaskingImageView.superview) {
        return;
    }
    
    //Animate away
    [UIView animateWithDuration:0.15f animations:^{
        self.screenshotForMultitaskingImageView.alpha = 0;
    } completion:^(BOOL finished) {
         [self.screenshotForMultitaskingImageView removeFromSuperview];
         self.screenshotForMultitaskingImageView = nil;
    }];
}

#pragma mark Application methods

-(void)applicationWillResignActive:(UIApplication *)application
{
    //Use blurred image for multitasking screenshot
    [self addMultitaskingScreenshot];
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

-(void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    //Remove blurred image for multitasking screenshot
    [self removeMultitaskingScreenshot];
}

-(void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Notification Methods

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [NotificationsManager didReceiveLocalNotification:notification.userInfo];
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [NotificationsManager didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [NotificationsManager didFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [NotificationsManager didReceiveRemoteNotification:userInfo];
}

@end
