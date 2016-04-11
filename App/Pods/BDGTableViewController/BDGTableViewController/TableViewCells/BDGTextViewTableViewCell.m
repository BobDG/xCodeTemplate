//
//  BDGTableTextViewCell.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGTextViewTableViewCell.h"

@interface BDGTextViewTableViewCell () <UITextViewDelegate>
{
    
}

@property(nonatomic) float previousHeight;
@property(nonatomic) float preferredHeightOneLine;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@end

@implementation BDGTextViewTableViewCell

-(void)updateCell
{
    if(self.row.textValue.length) {
        self.textView.text = self.row.textValue;
    }
    if(self.row.placeholder.length) {
        self.textView.placeholder = self.row.placeholder;
    }
    
    //Editable
    self.textView.userInteractionEnabled = !self.row.disableEditing;
}

-(void)awakeFromNib
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [toolBar setItems:@[space, done]];
    [toolBar sizeToFit];
    self.textView.inputAccessoryView = toolBar;
    
    //Set constant
    self.previousHeight = self.textViewHeightConstraint.constant;
    self.preferredHeightOneLine = self.previousHeight;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected) {
        [self.textView becomeFirstResponder];
    }
}

-(void)done
{
    [self.textView resignFirstResponder];
    if(self.row.doneChanging) {
        self.row.doneChanging();
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    //Set height constraint
    float heightThatFitsTextView = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX)].height;
    float newConstant;
    if(heightThatFitsTextView>self.preferredHeightOneLine) {
        newConstant = heightThatFitsTextView;
    }
    else {
        newConstant = self.preferredHeightOneLine;
    }
    if(newConstant != self.previousHeight) {
        self.textViewHeightConstraint.constant = newConstant;
        self.previousHeight = newConstant;
        [self setNeedsUpdateConstraints];
        [self layoutIfNeeded];
        
        if(self.heightUpdated) {
            self.heightUpdated();
        }
    }
    
    self.row.textValue = textView.text;
    [self.row updatedValue:self.row.textValue];
}

@end






























