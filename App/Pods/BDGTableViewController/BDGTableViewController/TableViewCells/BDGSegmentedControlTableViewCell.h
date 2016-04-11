//
//  BDGTableSegmentedControlCell.h
//  MINGL
//
//  Created by Bob de Graaf on 26-06-15.
//  Copyright (c) 2015 Digitalisma. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTableViewCell.h"

@interface BDGSegmentedControlTableViewCell : BDGTableViewCell
{
    
}

//Outlets
@property(nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;

@end