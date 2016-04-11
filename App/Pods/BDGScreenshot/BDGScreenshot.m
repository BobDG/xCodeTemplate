//
//  BDGScreenshot.m
//
//  Created by Bob de Graaf on 31-05-12.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BDGScreenshot.h"

@implementation BDGScreenshot

+(UIImage *)screenshotFromAllWindows
{
    CGRect screenCaptureRect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContextWithOptions(screenCaptureRect.size, NO, 0.0f);
    for(UIWindow *window in [UIApplication sharedApplication].windows) {
        [window drawViewHierarchyInRect:screenCaptureRect afterScreenUpdates:NO];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+(UIImage *)screenshotFromView:(UIView *)view
{
    return [self screenshotFromView:view renderInContext:TRUE afterScreenUpdates:FALSE];
}

+(UIImage *)screenshotFromView:(UIView *)view afterScreenUpdates:(BOOL)afterScreenUpdates
{
    return [self screenshotFromView:view renderInContext:FALSE afterScreenUpdates:afterScreenUpdates];
}

+(UIImage *)screenshotFromView:(UIView *)view renderInContext:(BOOL)renderInContext
{
    return [self screenshotFromView:view renderInContext:renderInContext afterScreenUpdates:FALSE];
}

+(UIImage *)screenshotFromView:(UIView *)view renderInContext:(BOOL)renderInContext afterScreenUpdates:(BOOL)afterScreenUpdates
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    if(renderInContext) {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    else {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:afterScreenUpdates];
    }
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

+(UIImage *)screenshotFromView:(UIView *)view side:(ScreenshotSide)screenshotSide
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *screenshot = [self screenshotFromView:view];
    CGRect specRect = CGRectZero;
    UIImage *result = nil;
    if(screenshotSide == kScreenshotSideTop) {
        specRect = CGRectMake(0, 0, view.frame.size.width*scale, (view.frame.size.height/2)*scale);
    }
    else if(screenshotSide == kScreenshotSideBottom) {
        specRect = CGRectMake(0, (view.frame.size.height/2)*scale, view.frame.size.width*scale, (view.frame.size.height/2)*scale);
    }
    else if(screenshotSide == kScreenshotSideLeft) {
        specRect = CGRectMake(0, 0, (view.frame.size.width/2)*scale, view.frame.size.height*scale);
    }
    else if(screenshotSide == kScreenshotSideRight) {
        specRect = CGRectMake(0, 0, (view.frame.size.width/2)*scale, view.frame.size.height*scale);
    }
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], specRect);
    result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}

+(NSArray *)screenshotVerticalsFromView:(UIView *)view
{
    UIImage *screenshot = [self screenshotFromView:view];
    return [self verticalHalfsFromImage:screenshot];
}

+(NSArray *)screenshotHorizontalsFromView:(UIView *)view
{
    UIImage *screenshot = [self screenshotFromView:view];
    return [self horizontalHalfsFromImage:screenshot];
}

+(NSArray *)verticalHalfsFromImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIImage *resultUp = nil;
    {
        CGRect upRect = CGRectMake(0, 0, image.size.width*scale, (image.size.height/2)*scale);
        CGImageRef imageRefUp = CGImageCreateWithImageInRect(image.CGImage, upRect);
        resultUp = [UIImage imageWithCGImage:imageRefUp];
        CGImageRelease(imageRefUp);
    }
    UIImage *resultDown = nil;
    {
        CGRect downRect = CGRectMake(0, (image.size.height/2)*scale, image.size.width*scale, (image.size.height/2)*scale);
        CGImageRef imageRefDown = CGImageCreateWithImageInRect(image.CGImage, downRect);
        resultDown = [UIImage imageWithCGImage:imageRefDown];
        CGImageRelease(imageRefDown);
    }
    return @[resultUp, resultDown];
}

+(NSArray *)horizontalHalfsFromImage:(UIImage *)image
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *resultLeft = nil;
    {
        CGRect leftRect = CGRectMake(0, 0, (image.size.width/2)*scale, image.size.height*scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], leftRect);
        resultLeft = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    UIImage *resultRight = nil;
    {
        CGRect rightRect = CGRectMake((image.size.width/2)*scale, 0, (image.size.width/2)*scale, image.size.height*scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rightRect);
        resultRight = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    return @[resultLeft, resultRight];
}

@end


































