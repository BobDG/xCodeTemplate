//
//  AppDelegate.h
//
//  Created by Bob de Graaf on 02-01-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}

//Properties
@property(nonatomic,strong) UIWindow *window;

//Public methods
-(void)continueLaunchFlow;
-(void)setRootViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end