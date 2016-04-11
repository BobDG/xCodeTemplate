//
//  BDGPickerViewTableViewCell.h
//  AllergyApp
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTableViewCell.h"
#import "BDGPickerViewField.h"

@interface BDGPickerViewTableViewCell : BDGTableViewCell
{
    
}

@property(nonatomic,weak) IBOutlet BDGPickerViewField *pickerField;

@end
