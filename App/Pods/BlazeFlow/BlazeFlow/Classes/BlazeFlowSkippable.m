//
//  BlazeFlowSkippable.m
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlowSkippable.h"

@implementation BlazeFlowSkippable

-(BOOL)isFirstState:(NSInteger)state
{
    if(state <= 1 && self.currentSkippableType != BlazeFlowSkippableTypeSkip) {
        return true;
    } else if(state <= self.skippableTypeSkipFirstState) {
        return true;
    }
    return false;
}

-(BOOL)isLastState:(NSInteger)state
{
    if(state >= self.numberOfStates && self.currentSkippableType != BlazeFlowSkippableTypeSkip) {
        return true;
    } else if(state-self.skippableTypeSkipFirstState+1 >= self.numberOfStates && self.currentSkippableType == BlazeFlowSkippableTypeSkip) {
        return true;
    }
    return false;
}

-(void)setNumberOfStates:(NSInteger)numberOfStates
{
    _numberOfStates = numberOfStates;
    if(self.skippableTypeSkipFirstState) {
        _numberOfStates -= (self.skippableTypeSkipFirstState-1);
    }
}

-(void)setSkippableTypeSkipFirstState:(NSInteger)skippableTypeSkipFirstState
{
    _skippableTypeSkipFirstState = skippableTypeSkipFirstState;
    self.currentState = skippableTypeSkipFirstState;
    if(self.numberOfStates) {
        _numberOfStates -= (self.skippableTypeSkipFirstState-1);
    }
}


@end
