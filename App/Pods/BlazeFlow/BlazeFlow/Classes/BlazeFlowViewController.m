//
//  blazeFlowViewController.m
//  Clinicards
//
//  Created by Roy Derks on 01/12/2016.
//  Copyright © 2016 Synappz BV. All rights reserved.
//

#import "BlazeFlow.h"
#import "BlazeFlowViewController.h"
#import "BlazeFlowTableViewController.h"

@interface BlazeFlowViewController ()

@end

@implementation BlazeFlowViewController

-(instancetype)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    self.blazeFlowTableViewControllerClass = [BlazeTableViewController class];
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.backLabel.text = NSLocalizedString(@"Navbar_Item_Cancel", nil);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pageControl.numberOfPages = self.blazeFlow.numberOfStates;
}

-(void)viewWillDisappear:(BOOL)animated
{
    @try {
        [self.blazeFlow removeObserver:self forKeyPath:@"currentState"];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.description);
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentState"]) {
        NSInteger currentState = [change[NSKeyValueChangeNewKey] integerValue];
        self.backLabel.text = currentState == 1? NSLocalizedString(@"Navbar_Item_Cancel", nil):NSLocalizedString(@"Navbar_Item_Back", nil);
        self.pageControl.currentPage = MAX(0,currentState-1);
    }
}

#pragma mark IBActions

-(IBAction)closeTapped
{
    [self close];
}

-(void)stateFinished
{
    [self next];
}

-(IBAction)previousTapped
{
    [self previous];
}

#pragma mark Setup

-(void)setupBlazeFlow
{
    self.blazeFlow.blazeFlowTableViewController = self.blazeFlowTableViewController;
    
    __weak typeof(self) weakSelf = self;
    self.blazeFlow.stateFinished = ^() {
        [weakSelf stateFinished];
    };
    self.blazeFlow.shouldDisplayaccessories = ^(NSInteger show) {
        [weakSelf shouldDisplayAccessories:show];
    };
    [self.blazeFlow addObserver:self forKeyPath:@"currentState" options:NSKeyValueObservingOptionNew context:nil];
    self.blazeFlow.shouldDisplayaccessories(-1);
}

#pragma mark Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Class class = !self.blazeFlowTableViewControllerClass?[BlazeFlowTableViewController class]:self.blazeFlowTableViewControllerClass;
    if([segue.identifier isEqualToString:NSStringFromClass(class)]) {
        self.blazeFlowTableViewController = segue.destinationViewController;
        [self setupBlazeFlow];
    }
}

#pragma mark - Overridable methods

-(void)stateFinishedSuccesfully
{
    //To override
}

-(void)shouldDisplayAccessories:(NSInteger)show
{
    //To override
}

-(BOOL)previous
{
    BOOL firstStateImminent = [self.blazeFlow isFirstState:self.blazeFlow.currentState-1];
    if(firstStateImminent) {
        self.backLabel.text = NSLocalizedString(@"Navbar_Item_Cancel", nil);
    }
    return [self.blazeFlow previous];
}

-(BOOL)next
{
    if([self.backLabel.text isEqualToString:NSLocalizedString(@"Navbar_Item_Cancel", nil)]) {
        self.backLabel.text = NSLocalizedString(@"Navbar_Item_Back", nil);
    }
    return [self.blazeFlow next];
}

-(BOOL)close
{
    return [self.blazeFlow close];
}

@end







































