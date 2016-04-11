//
//  APPickerViewTableViewCell.m
//  AllergyApp
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGPickerViewTableViewCell.h"

@implementation BDGPickerViewTableViewCell

-(void)updateCell
{
    self.pickerField.pickerValues = self.row.selectorOptions;
    
    NSUInteger index = NSNotFound;
    if(self.row.textValue.length) {
        index = [self.row.selectorOptions indexOfObject:self.row.textValue];
    }
    
    //Placeholder
    self.pickerField.placeholder = self.row.placeholder;
    
    //Placeholder color
    if(self.row.placeholder.length && self.row.placeholderColor) {
        self.pickerField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.pickerField.text attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    
    //Index
    if(index == NSNotFound) {
        self.pickerField.text = @"";
        return;
    }    
    self.row.pickerSelectedIndex = (int)index;
    if(self.row.pickerSelectedIndex < self.row.selectorOptions.count) {
        self.pickerField.text = self.row.selectorOptions[self.row.pickerSelectedIndex];
    }
    self.pickerField.selectedIndex = self.row.pickerSelectedIndex;
    
    //Editable
    self.pickerField.userInteractionEnabled = !self.row.disableEditing;
}

-(void)awakeFromNib
{
    __weak __typeof(self)weakSelf = self;
    [self.pickerField setPickerCancelled:^{
        [weakSelf resignFirstResponder];
    }];
    [self.pickerField setPickerSelected:^(int index) {
        [weakSelf resignFirstResponder];
        self.row.pickerSelectedIndex = index;
        if(index < self.row.selectorOptions.count) {
            self.pickerField.text = self.row.selectorOptions[index];
        }
        [self.row updatedValue:@(index)];
    }];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected) {
        [self.pickerField becomeFirstResponder];
    }
}

@end
