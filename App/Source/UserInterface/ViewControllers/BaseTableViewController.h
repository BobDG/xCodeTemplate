//
//  BaseTableViewController.h
//  Template
//
//  Created by Bob de Graaf on 03-05-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "BlazeTableViewCell.h"
#import "BlazeTableViewController.h"

//Headers
#define XIBTableHeaderView                      @"TableHeaderView"

//Original cells
#define XIBTextTableViewCell                    @"TextTableViewCell"
#define XIBSwitchTableViewCell                  @"SwitchTableViewCell"
#define XIBCheckboxTableViewCell                @"CheckboxTableViewCell"
#define XIBTextViewTableViewCell                @"TextViewTableViewCell"
#define XIBCenterTextTableViewCell              @"CenterTextTableViewCell"
#define XIBEmptySpaceTableViewCell              @"EmptySpaceTableViewCell"
#define XIBTextButtonTableViewCell              @"TextButtonTableViewCell"
#define XIBCircleImageTableViewCell             @"CircleImageTableViewCell"
#define XIBFloatTextFieldTableViewCell          @"FloatTextFieldTableViewCell"
#define XIBSmallTextButtonTableViewCell         @"SmallTextButtonTableViewCell"

@interface BaseTableViewController : BlazeTableViewController
{
    
}

-(void)updateUser;
@property(nonatomic,strong) User *user;

@end

































