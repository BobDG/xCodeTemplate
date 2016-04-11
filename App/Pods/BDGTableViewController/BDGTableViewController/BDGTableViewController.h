//
//  BDGTableViewController.h
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "BDGTableRow.h"
#import "BDGTableSection.h"

@interface BDGTableViewController : UITableViewController
{
    
}

//Empty set
@property(nonatomic) bool emptyScrollable;
@property(nonatomic) float emptyVerticalOffset;
@property(nonatomic,strong) UIImage *emptyImage;
@property(nonatomic,strong) NSString *emptyTitle;
@property(nonatomic,strong) UIColor *emptyBackgroundColor;
@property(nonatomic,strong) NSDictionary *emptyTitleAttributes;

//Methods to override
-(void)registerAdditionalCells;
-(void)registerAdditionalHeaders;
-(NSString *)defaultXIBForEnum:(BDGTableRowType)rowType;

//TableArray
@property(nonatomic,strong) NSMutableArray *tableArray;

//DraggableZoom headerView
@property(nonatomic,strong) UIView *zoomTableHeaderView;

//Utility methods
-(void)reloadTable:(BOOL)animated;
-(void)scrollToTop:(BOOL)animated;
-(void)reloadCellForID:(int)rowID;
-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowWithID:(int)rowID;
-(BDGTableRow *)rowForID:(int)rowID;
-(void)nextTextField:(BDGTableRow *)row;
-(void)removeSectionWithID:(int)sectionID;
-(void)addSection:(BDGTableSection *)section;
-(NSIndexPath *)indexPathForRowID:(int)rowID;
-(BDGTableSection *)sectionForID:(int)sectionID;
-(void)registerCustomCells:(NSArray *)cellNames;
-(void)addRow:(BDGTableRow *)row afterRowID:(int)afterRowID;
-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex;
-(void)addSection:(BDGTableSection *)section afterSectionID:(int)afterSectionID;

@end























