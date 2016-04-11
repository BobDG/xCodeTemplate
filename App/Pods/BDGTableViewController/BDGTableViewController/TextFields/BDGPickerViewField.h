//
//  BDGPickerViewField.h
//  AllergyApp
//
//  Created by Bob de Graaf on 18-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDGPickerViewField : UITextField
{
    
}

@property(nonatomic) int selectedIndex;
@property(nonatomic,strong) NSArray *pickerValues;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,copy) void (^pickerCancelled)(void);
@property(nonatomic,copy) void (^pickerSelected)(int index);

@end