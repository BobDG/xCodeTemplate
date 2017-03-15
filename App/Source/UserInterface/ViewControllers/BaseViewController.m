//
//  BaseViewController.m
//  OfficeApp
//
//  Created by Bob de Graaf on 03-02-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //Update
    [self updateUser];
    
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
