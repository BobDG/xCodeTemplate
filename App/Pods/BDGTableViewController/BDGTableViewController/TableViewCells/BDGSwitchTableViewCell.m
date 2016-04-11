//
//  BDGTableSwitchCell.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGSwitchTableViewCell.h"

@implementation BDGSwitchTableViewCell

-(IBAction)cellSwitched:(id)sender
{
    self.row.booleanValue = self.cellSwitch.on;
    [self.row updatedValue:@(self.cellSwitch.on)];
}

-(void)updateCell
{
    self.cellSwitch.on = self.row.booleanValue;
    
    //Editable
    self.cellSwitch.userInteractionEnabled = !self.row.disableEditing;
}

@end
