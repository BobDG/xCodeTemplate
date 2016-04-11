//
//  BDGTableRow.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGTableRow.h"

@implementation BDGTableRow

#pragma mark Init

-(id)initWithID:(int)ID
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    
    return self;
}

-(id)initWithID:(int)ID title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType title:(NSString *)title
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType title:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    self.placeholder = placeholder;
    
    return self;
}

-(id)initWithID:(int)ID rowType:(BDGTableRowType)rowType title:(NSString *)title textValue:(NSString *)textValue placeholder:(NSString *)placeholder
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.ID = ID;
    self.title = title;
    self.rowType = rowType;
    self.textValue = textValue;
    self.placeholder = placeholder;
    
    return self;
}

-(void)setAffectedObject:(id)affectedObject affectedPropertyName:(NSString *)affectedPropertyName
{
    self.object = affectedObject;
    self.propertyName = affectedPropertyName;
}

-(void)didUpdateValue:(id)value
{
    if(self.object && self.propertyName.length) {
        [self.object setValue:value forKey:self.propertyName];
    }
    if(self.doneChanging) {
        self.doneChanging();
    }
    
}

-(void)updatedValue:(id)value
{
    if(self.object && self.propertyName.length) {
        [self.object setValue:value forKey:self.propertyName];
    }
    if(self.valueChanged) {
        self.valueChanged();
    }
}

@end
