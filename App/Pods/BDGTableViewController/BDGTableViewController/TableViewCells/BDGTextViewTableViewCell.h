//
//  BDGTableTextViewCell.h
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTextView.h"
#import "BDGTableViewCell.h"

@interface BDGTextViewTableViewCell : BDGTableViewCell
{
    
}

//Outlets
@property(nonatomic,weak) IBOutlet BDGTextView *textView;

@end