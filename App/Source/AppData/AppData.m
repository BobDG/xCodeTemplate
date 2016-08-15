//
//  AppData.m
//
//  Created by Bob de Graaf on 30-01-13.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <HockeySDK/HockeySDK.h>

#import "AppData.h"
#import "Constants.h"

@implementation AppData

+(void)setupAppData
{
    //User defaults
    [self setupUserDefaults];
        
    //ThirdParties
    [self setupThirdParties];
}

#pragma mark UserDefaults

+(void)setupUserDefaults
{
    NSString *versionCheck = @"Version1.0.0";
    if(![nsprefs boolForKey:versionCheck])
    {
        
        [nsprefs setBool:TRUE forKey:versionCheck];
        [nsprefs synchronize];
    }
}

#pragma mark ThirdParties

+(void)setupThirdParties
{
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:[[[NSBundle mainBundle] infoDictionary]objectForKey:@"HockeyApp"]];
    [BITHockeyManager sharedHockeyManager].disableMetricsManager = YES;
    [[BITHockeyManager sharedHockeyManager] startManager];
}

#pragma mark - Utility methods

+(id)loadJSONForFileName:(NSString *)fileName
{
    NSString *jsonPath = [MAIN_BUNDLE pathForResource:fileName ofType:@"json"];
    if(![FILE_MANAGER fileExistsAtPath:jsonPath]) {
        DLog(@"File not found: %@", jsonPath);
        return nil;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *serializeError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&serializeError];
    if(serializeError) {
        DLog(@"Error converting json data: %@", serializeError.description);
        return nil;
    }
    
    return jsonObject;
}

@end
















