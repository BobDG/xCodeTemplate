//
//  BDGTableSection.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGTableSection.h"

@implementation BDGTableSection

-(id)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.rows = [[NSMutableArray alloc] init];
    
    return self;
}

-(id)initWithID:(int)ID text:(NSString *)text backgroundColor:(UIColor *)backgroundColor
{
    self = [self init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.text = text;
    self.backgroundColor = backgroundColor;
    
    return self;
}

-(void)addRow:(id)row
{
    [self.rows addObject:row];
}

@end