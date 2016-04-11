//
//  BDGTableViewCell.m
//  AllergyApp
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "BDGTableViewCell.h"

@implementation BDGTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell
{
    //To be overridden
}

-(void)setRow:(BDGTableRow *)row
{
    _row = row;
    
    //Update Labels IF connected
    if(self.titleLabel) {
        [self updateLabel:self.titleLabel withText:self.row.title attributedText:self.row.attributedTitle];
    }
    if(self.subtitleLabel) {
        [self updateLabel:self.subtitleLabel withText:self.row.subtitle attributedText:self.row.attributeSubtitle];
    }
    if(self.subsubtitleLabel) {
        [self updateLabel:self.subsubtitleLabel withText:self.row.subsubtitle attributedText:self.row.attributeSubSubtitle];
    }
    
    //Update imageviews IF connected
    if(self.imageViewLeft) {
        [self updateImageView:self.imageViewLeft withData:self.row.imageDataLeft imageURLString:self.row.imageURLStringLeft imageName:self.row.imageNameLeft contentMode:self.row.contentModeLeft renderingMode:self.row.imageRenderModeLeft];
    }
    if(self.imageViewCenter) {
        [self updateImageView:self.imageViewCenter withData:self.row.imageDataCenter imageURLString:self.row.imageURLStringCenter imageName:self.row.imageNameCenter contentMode:self.row.contentModeCenter renderingMode:self.row.imageRenderModeCenter];
    }
    if(self.imageViewRight) {
        [self updateImageView:self.imageViewRight withData:self.row.imageDataRight imageURLString:self.row.imageURLStringRight imageName:self.row.imageNameRight contentMode:self.row.contentModeRight renderingMode:self.row.imageRenderModeRight];
    }
    if(self.imageViewBackground) {
        [self updateImageView:self.imageViewBackground withData:self.row.imageDataBackground imageURLString:self.row.imageURLStringBackground imageName:self.row.imageNameBackground contentMode:self.row.contentModeBackground renderingMode:self.row.imageRenderModeBackground];
    }
    
    //Update buttons IF connected
    if(self.buttonLeft) {
        [self.buttonLeft setTitle:self.row.buttonLeftTitle forState:UIControlStateNormal];
    }
    if(self.buttonCenter) {
        [self.buttonCenter setTitle:self.row.buttonCenterTitle forState:UIControlStateNormal];
    }
    if(self.buttonRight) {
        [self.buttonRight setTitle:self.row.buttonRightTitle forState:UIControlStateNormal];
    }
    
    //Update additionally
    [self updateCell];
}

#pragma mark - IBActions

-(IBAction)buttonLeftTapped:(id)sender
{
    if(self.row.buttonLeftTapped) {
        self.row.buttonLeftTapped();
    }
}

-(IBAction)buttonCenterTapped:(id)sender
{
    if(self.row.buttonCenterTapped) {
        self.row.buttonCenterTapped();
    }
}

-(IBAction)buttonRightTapped:(id)sender
{
    if(self.row.buttonRightTapped) {
        self.row.buttonRightTapped();
    }
}

#pragma mark - Update default UIViews

-(void)updateLabel:(UILabel *)label withText:(NSString *)text attributedText:(NSAttributedString *)attributedText
{
    if(attributedText.length) {
        label.attributedText = attributedText;
        return;
    }
    else if(text.length) {
        label.text = text;
    }
    else {
        label.text = @"";
    }
}

-(void)updateImageView:(UIImageView *)imageView withData:(NSData *)imageData imageURLString:(NSString *)imageURLString imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode renderingMode:(UIImageRenderingMode)renderingMode
{
    if(imageData) {
        imageView.image = [UIImage imageWithData:imageData];
    }
    else if(imageURLString.length) {
        [imageView setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:[UIImage new]];
    }
    else if(imageName.length) {
        imageView.image = [UIImage imageNamed:imageName];
    }
    if(contentMode != UIViewContentModeScaleToFill) {
        imageView.contentMode = contentMode;
    }
    if(renderingMode != UIImageRenderingModeAutomatic) {
        imageView.image = [imageView.image imageWithRenderingMode:renderingMode];
    }
}

@end
