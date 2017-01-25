//
//  BlazeFlowSkippable.h
//  BlazeFlow
//
//  Created by Roy Derks on 04/01/2017.
//  Copyright © 2017 Roy Derks. All rights reserved.
//

#import "BlazeFlow.h"

typedef NS_ENUM(NSInteger, BlazeFlowSkippableType) {
    BlazeFlowSkippableTypeNone = 0,
    BlazeFlowSkippableTypeDontSkip = 1,
    BlazeFlowSkippableTypeSkip = 2
};

@interface BlazeFlowSkippable : BlazeFlow

/**
 The currently applied BlazeFlowSkippableType
 */
@property(nonatomic,assign) BlazeFlowSkippableType currentSkippableType;

/**
 The first state for the currently applied BlazeFlowSkippableType
 */
@property(nonatomic,assign) NSInteger skippableTypeSkipFirstState;

@end
