//
//  BDGTileCollectionViewCell.h
//  AllergyApp
//
//  Created by Bob de Graaf on 15-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGInputTile.h"

@interface BDGTileCollectionViewCell : UICollectionViewCell
{
    
}

@property(nonatomic) bool active;

@property(nonatomic,strong) BDGInputTile *inputTile;

@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UIView *containerView;
@property(nonatomic,weak) IBOutlet UIImageView *imageView;

@end
