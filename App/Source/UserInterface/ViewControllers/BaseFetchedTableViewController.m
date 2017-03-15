//
//  BaseFetchedTableViewController.m
//  OfficeApp
//
//  Created by Bob de Graaf on 03-02-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeTableViewCell.h"
#import "BaseFetchedTableViewController.h"

@interface BaseFetchedTableViewController ()

@end

@implementation BaseFetchedTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set user
    [self updateUser];
    
    //Update content
    self.loadContentOnAppear = TRUE;
    
    //Default section header
    self.headerXibName = XIBTableHeaderView;
    
    //Default separator style
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //Empty back button for pushed controllers
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Update
    [self updateUser];
}

-(void)updateUser
{
    //User
    self.user = [AppData sharedAppData].user;
}

@end













