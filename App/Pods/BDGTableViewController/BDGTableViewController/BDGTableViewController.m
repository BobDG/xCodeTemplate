//
//  BDGTableViewController.h
//
//  Created by Bob de Graaf on 27-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>

//Defaults
#import "BDGTableViewController.h"

//CollectionView
#import "BDGTilesCollectionView.h"
#import "BDGTileCollectionViewCell.h"

//Standard cells
#import "BDGTableViewCell.h"

//TableViewHeaders
#import "BDGTableHeaderView.h"

//Definition Header
#define kBDGTableHeaderView         @"BDGTableHeaderView"

//Definitions of basic XIB's
#define BDGXIBDateCell              @"BDGDateTableViewCell"
#define BDGXIBTilesCell             @"BDGTilesTableViewCell"
#define BDGXIBSliderCell            @"BDGSliderTableViewCell"
#define BDGXIBSwitchCell            @"BDGSwitchTableViewCell"
#define BDGXIBTextViewCell          @"BDGTextViewTableViewCell"
#define BDGXIBTextFieldCell         @"BDGTextFieldTableViewCell"
#define BDGXIBPickerViewCell        @"BDGPickerViewTableViewCell"
#define BDGXIBSegmentedControlCell  @"BDGSegmentedControlTableViewCell"

@interface BDGTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    
}

@end

@implementation BDGTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //TableArray
    self.tableArray = [NSMutableArray new];
    
    //Register cells & Headers
    [self registerCellsAndHeaders];
    
    //Automatic rowHeight
    self.tableView.estimatedRowHeight = 60.0;
    self.tableView.estimatedSectionHeaderHeight = 60.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //No scrollbars
    self.tableView.showsVerticalScrollIndicator = FALSE;
    
    //Empty defaults
    self.emptyScrollable = FALSE;
    self.emptyVerticalOffset = -100.0f;
    self.emptyBackgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Empty datasource & delegate
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Registering Cells

-(void)registerAdditionalCells
{
    //To be overridden
}

-(void)registerAdditionalHeaders
{
    //To be overridden
}

-(void)registerCellsAndHeaders
{
    //Cells
    [self registerCustomCells:[self defaultCellsToRegister]];
    
    //Register header
    [self.tableView registerNib:[UINib nibWithNibName:kBDGTableHeaderView bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:kBDGTableHeaderView];
    
    //Additional Cells & Headers
    [self registerAdditionalCells];
    [self registerAdditionalHeaders];
}

-(void)registerCustomCells:(NSArray *)cellNames
{
    for(NSString *className in cellNames) {
        [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    }
}

-(NSArray *)defaultCellsToRegister
{
    return @[BDGXIBSliderCell,
             BDGXIBTilesCell,
             BDGXIBTextViewCell,
             BDGXIBDateCell,
             BDGXIBSegmentedControlCell,
             BDGXIBSwitchCell,
             BDGXIBTextFieldCell,
             BDGXIBPickerViewCell];
}

-(NSString *)defaultXIBForEnum:(BDGTableRowType)rowType
{
    switch (rowType) {
        case BDGRowBasic: {
            return BDGXIBTextFieldCell;
            break;
        }
        case BDGRowSwitch: {
            return BDGXIBSwitchCell;
            break;
        }
        case BDGRowDate: {
            return BDGXIBDateCell;
            break;
        }
        case BDGRowTextField: {
            return BDGXIBTextFieldCell;
            break;
        }
        case BDGRowTextView: {
            return BDGXIBTextViewCell;
            break;
        }
        case BDGRowSegmentedControl: {
            return BDGXIBSegmentedControlCell;
            break;
        }
        case BDGRowTiles: {
            return BDGXIBTilesCell;
            break;
        }
        case BDGRowPicker: {
            return BDGXIBPickerViewCell;
            break;
        }
        case BDGRowSlider: {
            return BDGXIBSliderCell;
            break;
        }
    }
}

#pragma mark ZoomTableHeaderView

-(void)setZoomTableHeaderView:(UIView *)zoomTableHeaderView
{
    _zoomTableHeaderView = zoomTableHeaderView;
    if(!zoomTableHeaderView) {
        return;
    }
    
    //Header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:self.zoomTableHeaderView.bounds];
    [headerContainer addSubview:self.zoomTableHeaderView];
    [headerContainer setClipsToBounds:NO];
    self.tableView.tableHeaderView = headerContainer;
}

#pragma mark Utility methods

-(void)reloadTable:(BOOL)animated
{
    if(animated && ([self.tableView numberOfSections] == [self numberOfSectionsInTableView:self.tableView])) {
        NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.tableView]);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadEmptyDataSet];
    }
    else {
        [self.tableView reloadData];
    }
}

-(void)scrollToTop:(BOOL)animated
{
    [self.tableView setContentOffset:CGPointZero animated:animated];
}

-(BDGTableRow *)rowForID:(int)rowID
{
    for(int i = 0; i < self.tableArray.count; i++) {
        BDGTableSection *section = self.tableArray[i];
        for(int j = 0; j < section.rows.count; j++) {
            BDGTableRow *r = section.rows[j];
            if(r.ID == rowID) {
                return r;
            }
        }
    }
    return nil;
}

-(BDGTableSection *)sectionForID:(int)sectionID
{
    for(int i = 0; i < self.tableArray.count; i++) {
        BDGTableSection *section = self.tableArray[i];
        if(section.ID == sectionID) {
            return section;
        }
    }
    return nil;
}

-(void)reloadCellForID:(int)rowID withRowAnimation:(UITableViewRowAnimation)animation
{
    //Let's get the indexPath of this cell
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    if(!indexPath) {
        return;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

-(void)reloadCellForID:(int)rowID
{
    //Let's get the indexPath of this cell
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    if(!indexPath) {
        return;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSIndexPath *)indexPathForRowID:(int)rowID
{
    NSUInteger rowIndex = NSNotFound;
    NSUInteger sectionIndex = NSNotFound;
    for(int i = 0; i < self.tableArray.count; i++) {
        BDGTableSection *section = self.tableArray[i];
        for(int j = 0; j < section.rows.count; j++) {
            BDGTableRow *r = section.rows[j];
            if(r.ID == rowID) {
                rowIndex = j;
                sectionIndex = i;
                break;
            }
        }
        if(sectionIndex != NSNotFound) {
            break;
        }
    }
    
    if(sectionIndex == NSNotFound || rowIndex == NSNotFound) {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

-(NSIndexPath *)indexPathForSectionID:(int)sectionID
{
    NSUInteger sectionIndex = NSNotFound;
    for(int i = 0; i < self.tableArray.count; i++) {
        BDGTableSection *section = self.tableArray[i];
        if(section.ID == sectionID) {
            sectionIndex = i;
        }
    }
    
    if(sectionIndex == NSNotFound) {
        return nil;
    }
    
    return [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
}

#pragma mark - Next/Previous Field Responders

-(BDGTableViewCell *)nextCellFromRow:(BDGTableRow *)row
{
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForRowID:row.ID];
    if(!indexPath) {
        return nil;
    }
    
    return [self nextCellFromIndexPath:indexPath];
}

-(BDGTableViewCell *)previousCellFromRow:(BDGTableRow *)row
{
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForRowID:row.ID];
    if(!indexPath) {
        return nil;
    }
    
    return [self previousCellFromIndexPath:indexPath];
}

-(BDGTableViewCell *)nextCellFromIndexPath:(NSIndexPath *)indexPath
{
    //Get next indexPath in the same section
    NSIndexPath *nextRowIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    BDGTableViewCell *nextRowCell = [self.tableView cellForRowAtIndexPath:nextRowIndexPath];
    if(nextRowCell) {
        return nextRowCell;
    }
    
    //Get next indexpath for the next section
    NSIndexPath *nextSectionIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section+1];
    BDGTableViewCell *nextSectionCell = [self.tableView cellForRowAtIndexPath:nextSectionIndexPath];
    if(nextSectionCell) {
        return nextSectionCell;
    }
    
    //Nothing..
    return nil;
}

-(BDGTableViewCell *)previousCellFromIndexPath:(NSIndexPath *)indexPath
{
    //Get previous indexPath in the same section
    NSIndexPath *previousRowIndexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
    BDGTableViewCell *previousRowCell = [self.tableView cellForRowAtIndexPath:previousRowIndexPath];
    if(previousRowCell) {
        return previousRowCell;
    }
    
    //Get previous indexpath for the previous section
    int previouSectionIndex = (int)indexPath.section-1;
    if(!previouSectionIndex || previouSectionIndex>=self.tableArray.count) {
        return nil;
    }
    
    BDGTableSection *section = self.tableArray[previouSectionIndex];
    if(!section.rows.count) {
        return nil;
    }
    
    NSIndexPath *previousSectionIndexPath = [NSIndexPath indexPathForRow:section.rows.count-1 inSection:previouSectionIndex];
    BDGTableViewCell *previousSectionCell = [self.tableView cellForRowAtIndexPath:previousSectionIndexPath];
    if(previousSectionCell) {
        return previousSectionCell;
    }
    
    //Nothing..
    return nil;
}

-(void)activateFirstResponderForCell:(BDGTableViewCell *)cell
{
    if(cell && cell.canBecomeFirstResponder) {
        [cell becomeFirstResponder];
    }
    else {
        [self.view endEditing:TRUE];
    }
}

-(void)activateNextFieldFromIndexPath:(NSIndexPath *)indexPath
{
    //Get next cell
    BDGTableViewCell *cell = [self nextCellFromIndexPath:indexPath];
    [self activateFirstResponderForCell:cell];
}

-(void)activatePreviousFieldFromIndexPath:(NSIndexPath *)indexPath
{
    //Get next cell
    BDGTableViewCell *cell = [self previousCellFromIndexPath:indexPath];
    [self activateFirstResponderForCell:cell];
}

#pragma mark Adding/Removing Rows/Sections

-(void)addSection:(BDGTableSection *)section
{
    [self.tableArray addObject:section];
}

-(void)removeRowsInSection:(int)sectionIndex fromIndex:(int)rowIndex
{
    //Possibly delete rows
    BDGTableSection *section = self.tableArray[sectionIndex];
    NSMutableArray *indexPathsToDelete = [NSMutableArray new];
    
    //Remove rows/indexpaths
    for(int i = (int)section.rows.count-1; i > rowIndex-1; i--) {
        [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
        [section.rows removeObject:section.rows[i]];
    }
    
    //Check if we need to delete any
    if(!indexPathsToDelete.count) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Remove rows
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)removeRowWithID:(int)rowID
{
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForRowID:rowID];
    
    //Sanity check
    if(!indexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Remove row from array
    BDGTableSection *section = self.tableArray[indexPath.section];
    [section.rows removeObjectAtIndex:indexPath.row];
    
    //Remove row
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)removeSectionWithID:(int)sectionID
{
    //Get section
    BDGTableSection *section = [self sectionForID:sectionID];
    
    //Sanity check
    if(!section) {
        return;
    }
    
    //Get current indexPath
    NSIndexPath *indexPath = [self indexPathForSectionID:sectionID];
    
    //Sanity check
    if(!indexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //Remove row from array
    [self.tableArray removeObject:section];
    
    //Remove section in tableview
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)addRow:(BDGTableRow *)row afterRowID:(int)afterRowID
{
    //Row exists already?
    NSIndexPath *existingIndexPath = [self indexPathForRowID:row.ID];
    if(existingIndexPath) {
        return;
    }
    
    //Get current indexPath
    NSIndexPath *currentIndexPath = [self indexPathForRowID:afterRowID];
    
    //Sanity check
    if(!currentIndexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //New indexPath
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row+1 inSection:currentIndexPath.section];
    
    //Insert row in section
    BDGTableSection *section = self.tableArray[newIndexPath.section];
    [section.rows insertObject:row atIndex:newIndexPath.row];
    
    //Add cell
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

-(void)addSection:(BDGTableSection *)section afterSectionID:(int)afterSectionID
{
    //Section exists already?
    if([self sectionForID:section.ID]) {
        return;
    }
    
    //Get current indexPath
    NSIndexPath *currentIndexPath = [self indexPathForSectionID:afterSectionID];
    
    //Sanity check
    if(!currentIndexPath) {
        return;
    }
    
    //Begin updates
    [self.tableView beginUpdates];
    
    //New indexPath
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:currentIndexPath.section+1];
    
    //Insert section
    [self.tableArray insertObject:section atIndex:newIndexPath.section];
    
    //Add cell
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:newIndexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
    //End updates
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BDGTableSection *s = self.tableArray[section];
    return s.rows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDGTableSection *s = self.tableArray[indexPath.section];
    BDGTableRow *row = s.rows[indexPath.row];
    
    if(row.rowHeight) {
        return row.rowHeight;
    }
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BDGTableSection *s = self.tableArray[section];
    if(s.text.length) {
        return UITableViewAutomaticDimension;
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDGTableSection *s = self.tableArray[section];
    if(!(s.text.length)) {
        return nil;
    }
    
    BDGTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kBDGTableHeaderView];
    headerView.titleLabel.text = s.text;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDGTableSection *section = self.tableArray[indexPath.section];
    BDGTableRow *row = section.rows[indexPath.row];
    
    NSString *cellName;
    if(row.xibName.length) {
        cellName = row.xibName;
    }
    else if(section.xibName.length) {
        cellName = section.xibName;
    }
    else if(self.xibName.length) {
        cellName = self.xibName;
    }
    else {
        cellName = [self defaultXIBForEnum:row.rowType];
    }
    
    BDGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    cell.row = row;
    [cell setHeightUpdated:^{
        [tableView beginUpdates];
        [tableView endUpdates];
    }];
    [cell setNextField:^{
        [self activateNextFieldFromIndexPath:indexPath];
    }];
    [cell setPreviousField:^{
        [self activatePreviousFieldFromIndexPath:indexPath];
    }];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDGTableSection *s = self.tableArray[indexPath.section];
    BDGTableRow *row = s.rows[indexPath.row];
    if(row.cellTapped) {
        row.cellTapped();
    }
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView != self.tableView) {
        return;
    }
    
    [self.view endEditing:TRUE];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView != self.tableView) {
        return;
    }
    
    if(!self.zoomTableHeaderView) {
        return;
    }
    
    float offset = scrollView.contentOffset.y;
    if(offset > 0) {
        return;
    }
    CGRect headerFrame = self.zoomTableHeaderView.frame;
    headerFrame.origin.y = offset;
    headerFrame.size.width = CGRectGetWidth(self.tableView.tableHeaderView.bounds);
    headerFrame.size.height = CGRectGetHeight(self.tableView.tableHeaderView.bounds) + fabs(offset);
    self.zoomTableHeaderView.frame = headerFrame;
    [self.zoomTableHeaderView layoutIfNeeded];
}

#pragma mark - DNZEmptyDataSet delegates

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if(!(self.emptyTitle.length)) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:self.emptyTitle attributes:self.emptyTitleAttributes];
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyImage;
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyBackgroundColor;
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.emptyVerticalOffset;
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return self.emptyScrollable;
}

#pragma mark Dealloc

-(void)dealloc
{
    self.tableView.emptyDataSetDelegate = nil;
    self.tableView.emptyDataSetSource = nil;
    self.tableView.delegate = nil;
}

@end


















