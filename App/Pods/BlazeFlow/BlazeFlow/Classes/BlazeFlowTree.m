//
//  BlazeFlowTree.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlowTree.h"
#import "BlazeFlowTableViewController.h"

@interface BlazeFlowTree()



@end

@implementation BlazeFlowTree


-(instancetype)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    self.previousStates = [NSMutableArray new];
    return self;
}

-(void)next
{
    if(self.nextState == 0) {
        if(self.nextOnLastState) {
            self.nextOnLastState();
        }
        return;
    }
    
    [self.previousStates addObject:@(self.currentState)];
    self.currentState = self.nextState;
    [self.blazeFlowTableViewController loadTableContent];
    self.nextState = 0;
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode:kCAFillModeBoth];
    [animation setDuration:.3];
    [[self.blazeFlowTableViewController.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    [self.blazeFlowTableViewController.tableView reloadData];
}


-(void)previous
{
    if(!self.previousStates.count) {
        if(self.previousOnFirstState) {
            self.previousOnFirstState();
        }
        return;
    }
    self.currentState = self.previousStates.lastObject.integerValue;
    [self.previousStates removeLastObject];
    [self.blazeFlowTableViewController loadTableContent];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode:kCAFillModeBoth];
    [animation setDuration:.3];
    [[self.blazeFlowTableViewController.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    [self.blazeFlowTableViewController.tableView reloadData];
}


@end
