//
//  TilesCollectionView.m
//  Mictielijst
//
//  Created by Bob de Graaf on 07-10-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import "BDGTilesCollectionView.h"
#import "BDGTileCollectionViewCell.h"

@implementation BDGTilesCollectionView

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if(!self) {
        return nil;
    }
    
    //Register Cells
    [self registerNib:[UINib nibWithNibName:@"BDGTileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BDGTileCollectionViewCell"];
    
    return self;
}

@end
