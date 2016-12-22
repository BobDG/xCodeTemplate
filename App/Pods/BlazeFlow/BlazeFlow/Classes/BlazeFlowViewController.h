//
//  InstructionFlowViewController.h
//  Clinicards
//
//  Created by Roy Derks on 01/12/2016.
//  Copyright © 2016 Synappz BV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlazeFlow,BlazeFlowTableViewController;

@interface BlazeFlowViewController : UIViewController


/**
 The BlazeFlow object associated with this BlazeFlowViewController and its BlazeFlowTableViewController.
 */
@property(nonatomic,strong) BlazeFlow *blazeFlow;

/**
 If you need to load a custom BlazeFlowTableViewController provide the Class with this property and name the seque after this Class.
 */
@property(nonatomic,assign) Class blazeFlowTableViewControllerClass;

/**
 The BlazeFlowTableViewController instance presenting the BlazeFlow.
 */
@property(nonatomic,strong) BlazeFlowTableViewController *blazeFlowTableViewController;


/**
 Bottom margin constraint for the default UIPageControl.
 */
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *pageControlBottomMarginConstraint;


/**
 The back button. Action is relayed to blazeViewController:previous
 */
@property(nonatomic,weak) IBOutlet UIButton *backButton;

/**
 The back button label. Defaults to localizedStrings Navbar_Item_Cancel and Navbar_Item_Back
 */
@property(nonatomic,weak) IBOutlet UILabel *backLabel;
/**
 The default UIImageView for the back arrow.
 */
@property(nonatomic,weak) IBOutlet UIImageView *arrowImageView;
/**
 The the container that holds all of the default back and close related outlets.
 */
@property(nonatomic,weak) IBOutlet UIView *backContainerView;


/**
 Default UIImageView for the close button.
 */
@property(nonatomic,weak) IBOutlet UIImageView *closeImageView;

/**
 Default UIButton on top of closeImageView. Action is relayed to blazeViewController:close
 */
@property(nonatomic,weak) IBOutlet UIButton *closeButton;


/**
 The UIView that holds the embedded BlazeFlowTableViewController
 */
@property(nonatomic,weak) IBOutlet UIView *containerView;


/**
 The default UIPageControl
 */
@property(nonatomic,weak) IBOutlet UIPageControl *pageControl;


/**
 This method is called when the BlazeFlow wants to inform that the current state has finished.
 */
-(void)stateFinished;

/**
 Using this method you can show/hide accessories like the backContainerView. Defaults to -1 = none, 0 = all.

 @param show user-defined type of showing to do.
 */
-(void)shouldDisplayAccessories:(NSInteger)show;

/**
 Method called when the backButton has been tapped.

 @return BOOL when the backButton was pressed while on the firstState
 */
-(BOOL)previous;

/**
 Method called when the backButton has been tapped.
 
 @return BOOL when next: message was sent to BlazeFlow while on the lastState
 */
-(BOOL)next;

/**
 Method called when the close button has been tapped

 @return YES when close: message was sent to BlazeFlow and disposing of and/or deactivating resources was successfull
 */
-(BOOL)close;

@end
