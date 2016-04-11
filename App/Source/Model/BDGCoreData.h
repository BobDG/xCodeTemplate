//
//  BDGCoreData.h
//  Template
//
//  Created by Bob de Graaf on 01-06-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

#define CoreData [BDGCoreData sharedBDGCoreData]

@interface BDGCoreData : NSObject
{
    
}

//Utility methods
-(NSArray *)objectsForEntity:(NSString *)entityName;
-(NSManagedObject *)firstObjectForEntity:(NSString *)entityName;
-(NSManagedObject *)objectWithID:(NSString *)idStr forEntity:(NSString *)entity;
-(NSArray *)objectsWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName;
-(NSManagedObject *)firstObjectWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName;

//Save
-(void)saveContext;

//Singleton
+(BDGCoreData *)sharedBDGCoreData;

//Context
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end