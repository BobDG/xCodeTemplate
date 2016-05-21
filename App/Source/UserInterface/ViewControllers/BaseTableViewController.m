//
//  BaseTableViewController.m
//  Template
//
//  Created by Bob de Graaf on 03-05-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "BaseTableViewController.h"

@interface BaseTableViewController ()
{
    
}

@end

@implementation BaseTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Register
    [self registerCustomCells:@[
                                XIBImageTableViewCell,
                                XIBButtonTableViewCell,
                                XIBTextFieldTableViewCell,
    ]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

@end
