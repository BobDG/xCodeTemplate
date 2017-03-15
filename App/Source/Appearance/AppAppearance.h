//
//  AppAppearance.h
//
//  Created by Bob de Graaf on 10-03-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AppAppearance : NSObject
{
    
}

//Setup
+(void)setupAppearance;

//Safari
+(void)showSafariViewControllerWithURL:(NSString *)urlStr fromViewController:(UIViewController *)viewController;

@end
