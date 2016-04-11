//
//  BDGTableDateCell.h
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTableViewCell.h"
#import "BDGDatePickerField.h"

@interface BDGDateTableViewCell : BDGTableViewCell
{
    
}

//Properties
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSDateFormatter *dateFormatter;

//Outlets
@property(nonatomic,weak) IBOutlet BDGDatePickerField *dateField;

@end