//
//  InstructionFlowTableViewController.m
//  Clinicards
//
//  Created by Roy Derks on 01/12/2016.
//  Copyright © 2016 Synappz BV. All rights reserved.
//

#import "BlazeFlowTableViewController.h"
#import "BlazeFlow.h"

@interface BlazeFlowTableViewController ()

@end

@implementation BlazeFlowTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loadContentOnAppear = false;
    [self loadTableContent];
}

-(void)loadTableContent
{
    self.tableView.userInteractionEnabled = false;
    //Clear
    [self.tableArray removeAllObjects];
    
    //Blaze
    BlazeSection *section = [self.blazeFlow sectionForState:self.blazeFlow.currentState];
    if(section) {
        [self addSection:section];
    }
    self.tableView.scrollEnabled = false;
    //Prevent the user from blazing through the flow, which could result in errors.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.350 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tableView.userInteractionEnabled = true;
    });
}

@end
