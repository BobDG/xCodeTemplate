//
//  BaseTableViewController.h
//  Template
//
//  Created by Bob de Graaf on 03-05-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "User.h"
#import "BlazeTableViewController.h"

//Headers
#define XIBTableHeaderView                  @"TableHeaderView"

//Cells
#define XIBTextTableViewCell                @"TextTableViewCell"
#define XIBImageTableViewCell               @"ImageTableViewCell"
#define XIBButtonTableViewCell              @"ButtonTableViewCell"
#define XIBSwitchTableViewCell              @"SwitchTableViewCell"
#define XIBCheckboxTableViewCell            @"CheckboxTableViewCell"
#define XIBTextViewTableViewCell            @"TextViewTableViewCell"
#define XIBTextFieldTableViewCell           @"TextFieldTableViewCell"
#define XIBCenterTextTableViewCell          @"CenterTextTableViewCell"
#define XIBEmptySpaceTableViewCell          @"EmptySpaceTableViewCell"
#define XIBTextButtonTableViewCell          @"TextButtonTableViewCell"
#define XIBCircleImageTableViewCell         @"CircleImageTableViewCell"
#define XIBFloatTextFieldTableViewCell      @"FloatTextFieldTableViewCell"
#define XIBSmallTextButtonTableViewCell     @"SmallTextButtonTableViewCell"

@interface BaseTableViewController : BlazeTableViewController
{
    
}

@property(nonatomic,strong) User *user;

@end
