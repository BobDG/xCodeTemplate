//
//  BDGTableViewCell.h
//  AllergyApp
//
//  Created by Bob de Graaf on 21-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTableRow.h"

@interface BDGTableViewCell : UITableViewCell
{
    
}

//Methods
-(void)updateCell;

//Callbacks
@property(nonatomic,copy) void (^heightUpdated)(void);
@property(nonatomic,copy) void (^nextTextField)(void);

//Properties
@property(nonatomic,strong) BDGTableRow *row;

//Labels
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subtitleLabel;
@property(nonatomic,weak) IBOutlet UILabel *subsubtitleLabel;

//Buttons
@property(nonatomic,weak) IBOutlet UIButton *buttonLeft;
@property(nonatomic,weak) IBOutlet UIButton *buttonCenter;
@property(nonatomic,weak) IBOutlet UIButton *buttonRight;

//ImageViews
@property(nonatomic,weak) IBOutlet UIImageView *imageViewLeft;
@property(nonatomic,weak) IBOutlet UIImageView *imageViewCenter;
@property(nonatomic,weak) IBOutlet UIImageView *imageViewRight;
@property(nonatomic,weak) IBOutlet UIImageView *imageViewBackground;

@end