//
//  BDGTableRow.h
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BDGTableRowType) {
    BDGRowBasic,
    BDGRowSwitch,
    BDGRowDate,
    BDGRowTextField,
    BDGRowTextView,
    BDGRowSegmentedControl,
    BDGRowTiles,
    BDGRowPicker,
    BDGRowSlider,
};

@interface BDGTableRow : NSObject
{
    
}

//Constructors
-(id)initWithID:(int)ID;
-(id)initWithID:(int)ID title:(NSString *)title;
-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType;
-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType title:(NSString *)title;
-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder;
-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType title:(NSString *)title textValue:(NSString *)textValue placeholder:(NSString *)placeholder;

//Methods
-(void)updatedValue:(id)value;
-(void)didUpdateValue:(id)value;
-(void)setAffectedObject:(id)affectedObject affectedPropertyName:(NSString *)affectedPropertyName;

//CompletionBlocks
@property(nonatomic,copy) void (^cellTapped)(void);
@property(nonatomic,copy) void (^valueChanged)(void);
@property(nonatomic,copy) void (^buttonLeftTapped)(void);
@property(nonatomic,copy) void (^buttonRightTapped)(void);
@property(nonatomic,copy) void (^buttonCenterTapped)(void);
@property(nonatomic,copy) void (^doneChanging)(void);
@property(nonatomic,copy) void (^multipleSelectionFinished)(NSMutableArray *selectedIndexPaths);

//Row
@property(nonatomic) int ID;
@property(nonatomic) int rowHeight;
@property(nonatomic) bool disableEditing;
@property(nonatomic) BDGTableRowType rowType;
@property(nonatomic,strong) NSString *xibName;

//Object & Possible property name
@property(nonatomic,strong) id object;
@property(nonatomic, strong) NSString *propertyName;

//Title
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSAttributedString *attributedTitle;

//Subtitle
@property(nonatomic,strong) NSString *subtitle;
@property(nonatomic,strong) NSAttributedString *attributeSubtitle;

//SubSubtitle
@property(nonatomic,strong) NSString *subsubtitle;
@property(nonatomic,strong) NSAttributedString *attributeSubSubtitle;

//Buttons
@property(nonatomic,strong) NSString *buttonLeftTitle;
@property(nonatomic,strong) NSString *buttonCenterTitle;
@property(nonatomic,strong) NSString *buttonRightTitle;

//ImageView left
@property(nonatomic,strong) NSData *imageDataLeft;
@property(nonatomic,strong) NSString *imageNameLeft;
@property(nonatomic,strong) NSString *imageURLStringLeft;
@property(nonatomic) UIViewContentMode contentModeLeft;
@property(nonatomic) UIImageRenderingMode imageRenderModeLeft;

//ImageView center
@property(nonatomic,strong) NSData *imageDataCenter;
@property(nonatomic,strong) NSString *imageNameCenter;
@property(nonatomic,strong) NSString *imageURLStringCenter;
@property(nonatomic) UIViewContentMode contentModeCenter;
@property(nonatomic) UIImageRenderingMode imageRenderModeCenter;

//ImageView right
@property(nonatomic,strong) NSData *imageDataRight;
@property(nonatomic,strong) NSString *imageNameRight;
@property(nonatomic,strong) NSString *imageURLStringRight;
@property(nonatomic) UIViewContentMode contentModeRight;
@property(nonatomic) UIImageRenderingMode imageRenderModeRight;

//ImageView background
@property(nonatomic,strong) NSData *imageDataBackground;
@property(nonatomic,strong) NSString *imageNameBackground;
@property(nonatomic,strong) NSString *imageURLStringBackground;
@property(nonatomic) UIViewContentMode contentModeBackground;
@property(nonatomic) UIImageRenderingMode imageRenderModeBackground;

//Slider
@property(nonatomic) int sliderMin;
@property(nonatomic) int sliderMax;
@property(nonatomic) float sliderValue;
@property(nonatomic,strong) NSString *sliderLeftText;
@property(nonatomic,strong) NSString *sliderCenterText;
@property(nonatomic,strong) NSString *sliderRightText;
@property(nonatomic,strong) NSString *sliderBackgroundImageName;

//Switch
@property(nonatomic) bool booleanValue;

//Tiles
@property(nonatomic) int tileHeight;
@property(nonatomic) int tilesPerRow;
@property(nonatomic) int selectedTile;
@property(nonatomic,strong) NSArray *tilesValues;

//Pickerview
@property(nonatomic) int pickerSelectedIndex;
@property(nonatomic,strong) NSArray *selectorOptions;

//Checkmark
@property(nonatomic) int selectedCheckmark;
@property(nonatomic,strong) NSString *checkmarkText1;
@property(nonatomic,strong) NSString *checkmarkText2;

//Date
@property(nonatomic,strong) NSDate *minDate;
@property(nonatomic,strong) NSDate *maxDate;
@property(nonatomic,strong) NSDate *dateValue;
@property(nonatomic,strong) NSDate *placeholderDate;
@property(nonatomic) UIDatePickerMode datePickerMode;
@property(nonatomic,strong) NSDateFormatter *dateFormatter;

//SegmentedControl
@property(nonatomic) int selectedSegmentIndex;

//TextField/TextView
@property(nonatomic) bool secureTextEntry;
@property(nonatomic) bool automaticNextField;
@property(nonatomic,strong) NSString *textValue;
@property(nonatomic) UIKeyboardType keyboardType;
@property(nonatomic,strong) NSString *placeholder;
@property(nonatomic,strong) UIColor *placeholderColor;
@property(nonatomic,strong) NSNumberFormatter *numberFormatter;

//MultipleSelector
@property(nonatomic) bool disableMultipleSelection;
@property(nonatomic,strong) NSString *multipleSelectorTitle;
@property(nonatomic,strong) NSArray *multipleSelectorValues;
@property(nonatomic,strong) NSMutableArray *selectedIndexPaths;

@end











