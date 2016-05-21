//
//  AppAppearance.m
//
//  Created by Bob de Graaf on 10-03-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "SVProgressHUD.h"
#import "AppAppearance.h"

@implementation AppAppearance

#pragma mark - Setup

+(void)setupAppearance
{
    //Progress circle
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor blueColor]];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    
    //Navigation Bar
    /*
    [[UINavigationBar appearance] setTranslucent:FALSE];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[self lightPurpleColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:kFontAmaticBold size:36.0f]}];
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:6 forBarMetrics:UIBarMetricsDefault];
     */
    
    //Toolbar
    /*
    [[UIToolbar appearance] setBarTintColor:[self purpleColor]];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:kFontLatoRegular size:18.0f]} forState:UIControlStateNormal];
     */
    
    //Tabbar
    /*
    [[UITabBar appearance] setTranslucent:FALSE];
    [[UITabBar appearance] setTintColor:[self orangeColor]];
    [[UITabBar appearance] setBarTintColor:[self blackColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[self orangeColor], NSFontAttributeName:[UIFont fontWithName:kFontOpenSansRegular size:9.0f]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:kFontOpenSansRegular size:9.0f]} forState:UIControlStateNormal];
     */
    
    //Cache keyboard
    [self cacheKeyboard];
    
    //Version
    [self setupVersionLabel];
}

#pragma mark - Colors




#pragma mark - Version Label

+(void)setupVersionLabel
{
    if(!APPSTORE) {
        // WAIT A SECOND FOR SCREEN TO ARRIVE
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            UIWindow *window = kAppDelegate.window;
            UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(10, window.frame.size.height-12, 90, 10)];
            version.backgroundColor = [UIColor clearColor];
            version.text = [NSString stringWithFormat:@"%@ (%@)",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
            version.font = [UIFont systemFontOfSize:10];
            [window addSubview:version];
        });
    }
}

#pragma mark Utility methods

+(void)cacheKeyboard
{
    UITextField *lagFreeField = [[UITextField alloc] init];
    [kAppDelegate.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];
}

+(UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

















