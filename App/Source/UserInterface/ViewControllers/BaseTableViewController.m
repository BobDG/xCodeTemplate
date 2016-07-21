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
    
    //Register headers
    [self registerCustomHeader:XIBTableHeaderView];
    
    //Register cells
    [self registerCustomCells:@[
                                XIBTextTableViewCell,
                                XIBImageTableViewCell,
                                XIBButtonTableViewCell,
                                XIBSwitchTableViewCell,
                                XIBCheckboxTableViewCell,
                                XIBTextViewTableViewCell,
                                XIBTextFieldTableViewCell,
                                XIBCenterTextTableViewCell,
                                XIBTextButtonTableViewCell,
                                XIBEmptySpaceTableViewCell,
                                XIBCircleImageTableViewCell,
                                XIBFloatTextFieldTableViewCell,
                                XIBSmallTextButtonTableViewCell,
                                ]];
}

@end
