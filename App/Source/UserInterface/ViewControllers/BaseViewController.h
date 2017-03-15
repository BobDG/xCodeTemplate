//
//  BaseViewController.h
//  OfficeApp
//
//  Created by Bob de Graaf on 03-02-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "BlazeViewController.h"
#import "BaseTableViewController.h"

@interface BaseViewController : BlazeViewController
{
    
}

-(void)updateUser;
@property(nonatomic,strong) User *user;

@end
