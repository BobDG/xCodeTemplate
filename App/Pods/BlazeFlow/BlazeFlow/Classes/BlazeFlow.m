//
//  BlazeFlow.m
//  Pods
//
//  Created by Roy Derks on 25/11/2016.
//
//

@import Blaze;

#import "BlazeFlow.h"
#import "BlazeFlowTableViewController.h"


@interface BlazeFlow()


@end

@implementation BlazeFlow

@synthesize numberOfStates = _numberOfStates;

-(instancetype)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    self.currentState = 1;
    return self;
}

#pragma mark Properties

-(void)setBlazeFlowTableViewController:(BlazeFlowTableViewController *)blazeFlowTableViewController
{
    _blazeFlowTableViewController = blazeFlowTableViewController;
    self.blazeFlowTableViewController.blazeFlow = self;
}

#pragma mark State

-(BOOL)isFirstState:(NSInteger)state
{
    if(state <= 1) {
        return true;
    }
    return false;
}

-(BOOL)isLastState:(NSInteger)state
{
    if(state >= self.numberOfStates) {
        return true;
    }
    return false;
}

-(void)setCurrentState:(NSInteger)currentState
{
    _currentState = currentState;
    if(self.currentStateChanged) {
        self.currentStateChanged(currentState);
    }
}

-(void)close
{
    //To override
}

#pragma mark Navigation

-(void)next
{
    if([self isLastState:self.currentState]) {
        if(self.nextOnLastState) {
            self.nextOnLastState();
        }
        return;
    }
    self.currentState++;
    [self animateNext];
}

-(void)previous
{
    if([self isFirstState:self.currentState]) {
        if(self.previousOnFirstState) {
            self.previousOnFirstState();
        }
        return;
    }
    self.currentState--;
    [self animatePrevious];
}

#pragma mark Navigation Animations

-(void)animateNext
{
    [self.blazeFlowTableViewController loadTableContent];
    
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFillMode:kCAFillModeBoth];
    [animation setDuration:.3];
    [[self.blazeFlowTableViewController.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
    [self.blazeFlowTableViewController.tableView reloadData];
}

-(void)animatePrevious
{
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

#pragma mark Flow

-(BlazeSection *)sectionForState:(NSInteger)state
{
    //To override
    return [BlazeSection new];
}

#pragma mark - Utility

-(void)alertWithMessage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"BlazeFlow_OK", nil) style:UIAlertActionStyleCancel handler:nil]];
    [self.blazeFlowTableViewController presentViewController:alertController animated:true completion:nil];
}

@end
