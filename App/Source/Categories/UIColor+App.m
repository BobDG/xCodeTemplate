//
//  UIColor+App.m
//
//  Created by Bob de Graaf on 10-03-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "UIColor+App.h"

@implementation UIColor (App)

#pragma mark - App Colors

+(UIColor *)appGreenColor
{
    return UIColorFromRGB(0x5AAEB4);
}

+(UIColor *)appTabBarColor
{
    return UIColorFromRGB(0x4FA2B5);
}

+(UIColor *)appLightTextColor
{
    return [UIColor whiteColor];
}

+(UIColor *)appUltraLightTextColor
{
    return UIColorFromRGB(0xDBDBDB);
}

+(UIColor *)appSeparatorColor
{
    return UIColorFromRGB(0xDBDBDB);
}

+(UIColor *)appDarkerTextColor
{
    return UIColorFromRGB(0xBFDCDE);
}

+(UIColor *)appDarkTextColor
{
    return UIColorFromRGB(0x242B42);
}

#pragma mark - Utilities

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

+(UIColor *)colorFromHexCode:(NSString *)hexCode
{
    hexCode = [NSString stringWithFormat:@"0x%@", hexCode];
    unsigned int hexValue = [self hexValueForString:hexCode];
    return UIColorFromRGB(hexValue);
}

+(unsigned int)hexValueForString:(NSString *)hexString
{
    unsigned int hexValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&hexValue];
    return hexValue;
}

@end
