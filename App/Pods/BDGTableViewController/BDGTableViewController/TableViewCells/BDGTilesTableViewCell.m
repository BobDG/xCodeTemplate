//
//  BDGTilesTableViewCell.m
//  AllergyApp
//
//  Created by Bob de Graaf on 05-01-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGTilesTableViewCell.h"
#import "BDGTileCollectionViewCell.h"

@interface BDGTilesTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    
}

@end

@implementation BDGTilesTableViewCell

-(void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell
{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.ID = self.row.ID;
    [self.collectionView reloadData];
    [self.row updatedValue:@(self.row.selectedTile)];
    
    //Editable
    self.collectionView.userInteractionEnabled = !self.row.disableEditing;
}

#pragma mark - UICollectionView DataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.row.tilesValues.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDGTileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BDGTileCollectionViewCell" forIndexPath:indexPath];
    NSArray *tilesArray = self.row.tilesValues;
    cell.inputTile = tilesArray[indexPath.row];
    cell.selected = cell.inputTile.ID == self.row.selectedTile;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tilesArray = self.row.tilesValues;
    float width = collectionView.bounds.size.width;
    float tileWidth = width/tilesArray.count;
    if(tilesArray.count>self.row.tilesPerRow) {
        tileWidth = width/self.row.tilesPerRow;
    }
    CGSize cellSize = CGSizeMake(round(tileWidth), self.row.tileHeight);
    return cellSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tilesArray = self.row.tilesValues;
    BDGInputTile *tile = tilesArray[indexPath.row];
    self.row.selectedTile = (int)indexPath.row;
    [self.row updatedValue:@(self.row.selectedTile)];
    for(BDGTileCollectionViewCell *cell in collectionView.visibleCells) {
        cell.selected = cell.inputTile == tile;
    }
}

@end







