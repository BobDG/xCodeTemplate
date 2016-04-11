//
//  BDGTextFieldTableViewCell.h
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTableViewCell.h"

@interface BDGTextFieldTableViewCell : BDGTableViewCell
{
    
}

@property(nonatomic,weak) IBOutlet UITextField *textField;

@end