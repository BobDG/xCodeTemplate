//
//  BlazeTableViewController.h
//  Blaze
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "BlazeRow.h"
#import "BlazeSection.h"
#import "NSObject+PropertyName.h"

@interface BlazeTableViewController : UITableViewController
{
    
}

//Optional Xibname for all rows/headers/footers in case they're all the same
@property(nonatomic,strong) NSString *rowsXibName;
@property(nonatomic,strong) NSString *headerXibName;
@property(nonatomic,strong) NSString *footerXibName;

//Empty set variables
@property(nonatomic) bool emptyScrollable;
@property(nonatomic) float emptyVerticalOffset;
@property(nonatomic,strong) UIImage *emptyImage;
@property(nonatomic,strong) NSString *emptyTitle;
@property(nonatomic,strong) UIColor *emptyBackgroundColor;
@property(nonatomic,strong) NSDictionary *emptyTitleAttributes;

//Heights
@property(nonatomic) float rowHeight;
@property(nonatomic) float sectionHeaderHeight;
@property(nonatomic) float sectionFooterHeight;

//Load content on appear
-(void)loadTableContent;
@property(nonatomic) bool loadContentOnAppear;

//Default XIB for rowtype
-(NSString *)defaultXIBForEnum:(BlazeRowType)rowType;

//TableArray
@property(nonatomic,strong) NSMutableArray *tableArray;

//DraggableZoom headerView
@property(nonatomic,strong) UIView *zoomTableHeaderView;

//Refreshcontrol
-(void)endRefreshing;
@property(nonatomic) bool enableRefreshControl;
@property(nonatomic,copy) void (^refreshControlPulled)(void);

//Utility methods
-(void)reloadHeightsQuickly;
-(void)reloadTable:(BOOL)animated;
-(void)scrollToTop:(BOOL)animated;
-(void)reloadCellForID:(int)rowID;
-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowWithID:(int)rowID;
-(void)removeRowWithID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation;
-(BlazeRow *)rowForID:(int)rowID;
-(void)removeSectionWithID:(int)sectionID;
-(void)addSection:(BlazeSection *)section;
-(NSIndexPath *)indexPathForRowID:(int)rowID;
-(void)registerCustomCell:(NSString *)xibName;
-(void)registerCustomHeader:(NSString *)xibName;
-(BlazeSection *)sectionForID:(int)sectionID;
-(void)registerCustomCells:(NSArray *)cellNames;
-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID;
-(void)addRow:(BlazeRow *)row afterRowID:(int)afterRowID withRowAnimation:(UITableViewRowAnimation)animation;
-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex;
-(void)addSection:(BlazeSection *)section afterSectionID:(int)afterSectionID;

@end






















