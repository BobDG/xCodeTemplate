//
//  AppData.m
//
//  Created by Bob de Graaf on 30-01-13.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import "User.h"
#import "AppData.h"
#import "HockeySDK.h"
#import "Constants.h"
#import "NSDate+Helper.h"
#import "NSManagedObject+Mapping.h"

@implementation AppData
SINGLETON_GCD(AppData);

+(void)setupAppData
{
    //ThirdParties
    [self setupThirdParties];
}

#pragma mark User

+(id)activeUser
{
    return [kCoreData objectsWithPredicate:[NSPredicate predicateWithFormat:@"active == %@", @(TRUE)] entityName:[User entityName]].firstObject;
}

-(User *)user
{
    if(!_user) {
        _user = [AppData activeUser];
    }
    return _user;
}

#pragma mark ThirdParties

+(void)setupThirdParties
{
    //HockeyApp
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
















