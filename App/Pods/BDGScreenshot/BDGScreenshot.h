//
//  BDGScreenshot.h
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ScreenshotSide) {
    kScreenshotSideTop,
    kScreenshotSideBottom,
    kScreenshotSideLeft,
    kScreenshotSideRight
};

@interface BDGScreenshot : NSObject

/* Take screenshot of all windows (thus including keyboard) */
+(UIImage *)screenshotFromAllWindows;

/* Take screenshot of different types */
+(UIImage *)screenshotFromView:(UIView *)view;
+(UIImage *)screenshotFromView:(UIView *)view side:(ScreenshotSide)screenshotSide;
+(UIImage *)screenshotFromView:(UIView *)view renderInContext:(BOOL)renderInContext;
+(UIImage *)screenshotFromView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates;
+(UIImage *)screenshotFromView:(UIView *)view renderInContext:(BOOL)renderInContext afterScreenUpdates:(BOOL)afterScreenUpdates;

/* Take screenshot and get halfs of the screenshot back in a NSArray */
+(NSArray *)screenshotVerticalsFromView:(UIView *)view;
+(NSArray *)screenshotHorizontalsFromView:(UIView *)view;

/* Simply divide the given image into halfs */
+(NSArray *)verticalHalfsFromImage:(UIImage *)image;
+(NSArray *)horizontalHalfsFromImage:(UIImage *)image;

@end