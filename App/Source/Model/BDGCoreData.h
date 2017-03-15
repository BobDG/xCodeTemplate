//
//  BDGCoreData.h
//  Template
//
//  Created by Bob de Graaf on 01-06-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

#define kCoreData [BDGCoreData sharedBDGCoreData]

@interface BDGCoreData : NSObject
{
    
}

//Utility methods
-(void)deleteObjects:(NSSet *)objects;
-(NSArray *)objectsForEntity:(NSString *)entityName;
-(void)deleteObjectsForEntity:(NSString *)entityName;
-(NSManagedObject *)firstObjectForEntity:(NSString *)entityName;
-(NSManagedObject *)objectWithID:(NSString *)idStr forEntity:(NSString *)entity;
-(NSArray *)objectsWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName;
-(NSManagedObject *)firstObjectWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName;

//Creating
-(NSArray *)createManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName;
-(NSManagedObject *)createManagedObject:(NSDictionary *)dictionary entityName:(NSString *)entityName;
-(NSArray *)createManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName dateFormatter:(NSDateFormatter *)dateFormatter;
-(NSArray *)createManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName dateFormatter:(NSDateFormatter *)dateFormatter mappingDictionary:(NSDictionary *)mappingDictionary;

//Updating
-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck;
-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck dateFormatter:(NSDateFormatter *)dateFormatter;
-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck isInteger:(BOOL)isInteger;
-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck isInteger:(BOOL)isInteger dateFormatter:(NSDateFormatter *)dateFormatter;

//Creating/updating single object
-(NSManagedObject *)updateObjectWithDictionary:(NSDictionary *)dictionary entityName:(NSString *)entityName idCheck:(NSString *)idCheck;
-(NSManagedObject *)updateObjectWithDictionary:(NSDictionary *)dictionary entityName:(NSString *)entityName idCheck:(NSString *)idCheck isInteger:(BOOL)isInteger;

//Save
-(void)saveContext;

//Singleton
+(BDGCoreData *)sharedBDGCoreData;

//Context
@property(nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end
