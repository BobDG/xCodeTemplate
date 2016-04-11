//
//  BDGTableSection.h
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BDGTableSection : NSObject
{
    
}

-(void)addRow:(id)row;
-(id)initWithID:(int)ID text:(NSString *)text backgroundColor:(UIColor *)backgroundColor;

@property(nonatomic) int ID;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *footer;
@property(nonatomic,strong) NSMutableArray *rows;
@property(nonatomic,strong) UIColor *backgroundColor;

@end