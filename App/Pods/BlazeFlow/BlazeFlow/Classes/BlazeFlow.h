//
//  BlazeFlow.h
//  Pods
//
//  Created by Roy Derks on 25/11/2016.
//
//

@import Foundation;

@class BlazeFlowTableViewController, BlazeSection, BlazeRow;

typedef NS_ENUM(NSInteger, BlazeFlowSkippableType) {
    BlazeFlowSkippableTypeNone = 0,
    BlazeFlowSkippableTypeDontSkip = 1,
    BlazeFlowSkippableTypeSkip = 2,
    BlazeFlowSkippableTypePartialSkip = 3
};

@interface BlazeFlow : NSObject

/**
 The number of states this BlazeFlow has. Default implementation is set to 0.
 */
@property(nonatomic,assign) NSInteger numberOfStates;

/**
 The current state the flow is in.
 */
@property(nonatomic,assign) NSInteger currentState;

/**
 Block to inform the BlazeFlowViewController what kind of accessories should be displayed. Default implementation shows backButton and pageControl on 1, and hides both on 0.
 */                              
@property(nonatomic,copy) void (^shouldDisplayaccessories)(NSInteger display);

/**
 Completion block when a state has finished. Default implementation in BlazeFlowViewController responds to this block with a next: message.
 */
@property(nonatomic,copy) void (^stateFinished)();

/**
 The presented BlazeTableViewController embedded in BlazeFlowViewController
 */
@property(nonatomic,strong) BlazeFlowTableViewController *blazeFlowTableViewController;

/**
 The currently applied BlazeFlowSkippableType
 */
@property(nonatomic,assign) BlazeFlowSkippableType currentSkippableType;

/**
 The first state for the currently applied BlaezFlowSkippableType
 */
@property(nonatomic,assign) NSInteger skippableTypeSkipFirstState;


/**
 @description Override this method to provide the BlazeFlowTableViewController with a dataSource.
 Should return a non-empty BlazeSection for the given state.

 @param state the state for which to return a BlazeSection
 @return BlazeSection object containing BlazeRows for the BlazeFlowTableViewController to present for given state
 */
-(BlazeSection*)sectionForState:(NSInteger)state;

/**
 Returns whether or not the given state is the last

 @param state the state to test for being the last state
 @return YES if the state is the last state, NO otherwise
 */
-(BOOL)isLastState:(NSInteger)state;

/**
 Returns whether or not the given state is the first.

 @param state the state to test for being the first state
 @return YES if state is the first state, NO otherwise
 */
-(BOOL)isFirstState:(NSInteger)state;

/**
 @description Present a UIAlertController with a message and an 'ok' button.
 Localizable with the string 'General_OK'.

 @param message The message to present to the user
 */
-(void)alertWithMessage:(NSString*)message;


/**
 Close the BlazeFlow immediately independant of currentState. Dispose or deactive resources.
 */
-(BOOL)close;

/**
 Present the next section in the flow.

 @return YES if cannot go any further forwards, NO otherwise.
 */
-(BOOL)next;

/**
 Present the previous section in the flow.

 @return YES if cannot go backwards any further, NO otherwise.
 */
-(BOOL)previous;

@end
