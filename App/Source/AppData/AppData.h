//
//  AppData.h
//
//  Created by Bob de Graaf on 30-01-13.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"
#import "Enums.h"

@interface AppData : NSObject
{
    
}

//Active user
@property(nonatomic,strong) User *user;

//User
+(User *)activeUser;

//Setup
+(void)setupAppData;

//Singleton
+(AppData *)sharedAppData;

@end
