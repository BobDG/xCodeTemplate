//
//  BDGTextFieldTableViewCell.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGTextFieldTableViewCell.h"

@interface BDGTextFieldTableViewCell () <UITextFieldDelegate>
{
    
}

@property(nonatomic) bool setupInputView;

@end

@implementation BDGTextFieldTableViewCell

-(void)updateCell
{    
    self.textField.text = self.row.textValue;
    self.textField.placeholder = self.row.placeholder;
    self.textField.keyboardType = self.row.keyboardType;
    self.textField.secureTextEntry = self.row.secureTextEntry;
    
    if(self.row.placeholder.length && self.row.placeholderColor) {
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName:self.row.placeholderColor}];
    }
    
    //Editable
    self.textField.userInteractionEnabled = !self.row.disableEditing;
}

-(void)awakeFromNib
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [toolBar setItems:@[space, done]];
    [toolBar sizeToFit];
    self.textField.inputAccessoryView = toolBar;
}

-(void)done
{
    [self.textField resignFirstResponder];
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.row.textValue = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(self.row.numberFormatter) {
        self.row.textValue = [self.row.numberFormatter stringForObjectValue:self.row.textValue];
        textField.text = self.row.textValue;
        [self.row updatedValue:self.row.textValue];
        return FALSE;
    }
    [self.row updatedValue:self.row.textValue];
    return TRUE;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
    if(self.row.automaticNextField && self.nextTextField) {
        self.nextTextField();    
    }
    else {
        [textField resignFirstResponder];
    }
    return TRUE;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected && self.textField.userInteractionEnabled) {
        [self.textField becomeFirstResponder];
    }
}

@end







