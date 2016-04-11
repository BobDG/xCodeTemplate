//
//  BDGTextView.h
//
//  Created by glaszig on 14.03.13.
//  Copyright (c) 2013 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDGTextView : UITextView

@property (nonatomic) IBInspectable double fadeTime;
@property (copy, nonatomic) IBInspectable NSString *placeholder;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;

@end