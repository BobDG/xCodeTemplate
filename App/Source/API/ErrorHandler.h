//
//  ErrorHandler.h
//
//  Created by Bob de Graaf on 03-02-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorUnauthorized      @"kErrorUnauthorized"

@interface ErrorHandler : NSObject
{
    
}

+(void)handleError:(NSError *)error fromViewController:(UIViewController *)viewController;
+(void)handleLoginError:(NSError *)error fromViewController:(UIViewController *)viewController;

@end
