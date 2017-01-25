//
//  BlazeFlowTree.h
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlow.h"

@interface BlazeFlowTree : BlazeFlow


/**
 The next state that should be presented when sending the next: message.
 */
@property(nonatomic,assign) NSInteger nextState;

/**
 The previous states with which the tree has traversed. The array's last object is the latest state.
 */
@property(nonatomic,strong) NSMutableArray<NSNumber*> *previousStates;

@end
