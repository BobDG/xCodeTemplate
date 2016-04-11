//
//  APTilesTableViewCell.h
//  AllergyApp
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDGTableViewCell.h"
#import "BDGTilesCollectionView.h"

@interface BDGTilesTableViewCell : BDGTableViewCell
{
    
}

@property(nonatomic,weak) IBOutlet BDGTilesCollectionView *collectionView;

@end
