//
//  BDGTableDateCell.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGDateTableViewCell.h"

@implementation BDGDateTableViewCell

-(void)updateCell
{
    self.date = self.row.dateValue;
    self.dateFormatter = self.row.dateFormatter;
    self.dateField.placeholder = self.row.placeholder;
    self.dateField.datePicker.datePickerMode = self.row.datePickerMode;
    
    if(self.row.minDate) {
        self.dateField.datePicker.minimumDate = self.row.minDate;
    }
    if(self.row.maxDate) {
        self.dateField.datePicker.maximumDate = self.row.maxDate;
    }
    
    //Update datepicker & datefield
    if(self.date) {
        self.dateField.date = self.date;
        if(self.dateFormatter) {
            self.dateField.text = [self.dateFormatter stringFromDate:self.date];
        }
    }
    else if(self.row.placeholderDate) {
        self.dateField.datePicker.date = self.row.placeholderDate;
    }
    
    //Placeholder color
    if(self.row.placeholder.length && self.row.placeholderColor) {
        self.dateField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.dateField.text attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    
    //Editable
    self.dateField.userInteractionEnabled = !self.row.disableEditing;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected) {
        [self.dateField becomeFirstResponder];
    }
}

-(void)awakeFromNib
{
    __weak __typeof(self)weakSelf = self;
    [self.dateField setDateCancelled:^{
        [weakSelf.dateField resignFirstResponder];
    }];
    [self.dateField setDateSelected:^(NSDate *date) {
        weakSelf.date = date;
        weakSelf.row.dateValue = date;
        if(weakSelf.dateFormatter) {
            weakSelf.dateField.text = [[self.dateFormatter stringFromDate:date] capitalizedString];
        }
        [weakSelf.row updatedValue:date];
    }];
}

-(IBAction)cellTapped:(id)sender
{
    [self.dateField becomeFirstResponder];
}

@end





























