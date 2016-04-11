//
//  BDGDatePickerField.h
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDGDatePickerField : UITextField
{
    
}

@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) UIDatePicker *datePicker;
@property(nonatomic,copy) void (^dateCancelled)(void);
@property(nonatomic,copy) void (^dateSelected)(NSDate *date);

@end