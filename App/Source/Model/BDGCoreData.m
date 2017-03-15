//
//  BDGCoreData.m
//  Template
//
//  Created by Bob de Graaf on 01-06-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "Constants.h"
#import "BDGCoreData.h"
#import "NSManagedObject+Mapping.h"

@interface BDGCoreData ()
{
    
}

@property(nonatomic,strong) NSString *modelName;
@property(nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic,strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation BDGCoreData

#pragma mark Init

-(id)init
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
#warning SET MODEL NAME
    self.modelName = @"Template";
    
    return self;
}

#pragma mark Utility methods

-(NSArray *)objectsForEntity:(NSString *)entityName
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    NSError *fetchError = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&fetchError];
    if(fetchError) {
        DLog(@"Error fetching results for entity: %@, error: %@", entityName, fetchError.description);
        return nil;
    }
    return results;
}

-(NSManagedObject *)firstObjectForEntity:(NSString *)entityName
{
    NSArray *results = [self objectsForEntity:entityName];
    if(results.count) {
        return results.firstObject;
    }
    return nil;
}

-(NSManagedObject *)objectWithID:(NSString *)idStr forEntity:(NSString *)entity
{
    return [self firstObjectWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", idStr] entityName:entity];
}

-(NSManagedObject *)firstObjectWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    [request setPredicate:predicate];
    NSError *fetchError = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&fetchError];
    if(fetchError) {
        DLog(@"Error fetching entity: %@, error: %@", entityName, fetchError.description);
        return nil;
    }
    if(!results.count) {
        return nil;
    }
    return results.firstObject;
}

-(NSArray *)objectsWithPredicate:(NSPredicate *)predicate entityName:(NSString *)entityName
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    [request setPredicate:predicate];
    NSError *fetchError = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&fetchError];
    if(fetchError) {
        DLog(@"Error fetching entity: %@", fetchError.description);
        return nil;
    }
    if(!results.count) {
        return nil;
    }
    return results;
}

-(void)deleteObjectsForEntity:(NSString *)entityName
{
    NSArray *allObjects = [self objectsForEntity:entityName];
    for(NSManagedObject *object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self saveContext];
}

-(void)deleteObjects:(NSSet *)objects
{
    for(NSManagedObject *object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
    [self saveContext];
}

#pragma mark - Creating objects

-(NSManagedObject *)createManagedObject:(NSDictionary *)dictionary entityName:(NSString *)entityName
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [object safeSetValuesForKeysWithDictionary:dictionary];
    return object;
}

-(NSArray *)createManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName
{
    return [self createManagedObjects:dictionariesArray entityName:entityName dateFormatter:nil];
}

-(NSArray *)createManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSMutableArray *objects = [NSMutableArray new];
    for(NSDictionary *dictionary in dictionariesArray) {
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        [object safeSetValuesForKeysWithDictionary:dictionary dateFormatter:dateFormatter];
        [objects addObject:object];
    }
    return objects;
}

-(NSArray *)createManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName dateFormatter:(NSDateFormatter *)dateFormatter mappingDictionary:(NSDictionary *)mappingDictionary
{
    NSMutableArray *objects = [NSMutableArray new];
    for(NSDictionary *dictionary in dictionariesArray) {
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        [object safeSetValuesForKeysWithDictionary:dictionary dateFormatter:dateFormatter context:kCoreData.managedObjectContext includeArrays:FALSE mappingDictionary:mappingDictionary];
        [objects addObject:object];
    }
    return objects;
}

-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck
{
    return [self updateManagedObjects:dictionariesArray entityName:entityName idCheck:idCheck isInteger:FALSE];
}

-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck dateFormatter:(NSDateFormatter *)dateFormatter
{
    return [self updateManagedObjects:dictionariesArray entityName:entityName idCheck:idCheck isInteger:FALSE dateFormatter:dateFormatter];
}

-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck isInteger:(BOOL)isInteger
{
    return [self updateManagedObjects:dictionariesArray entityName:entityName idCheck:idCheck isInteger:isInteger dateFormatter:nil];
}

-(NSArray *)updateManagedObjects:(NSArray *)dictionariesArray entityName:(NSString *)entityName idCheck:(NSString *)idCheck isInteger:(BOOL)isInteger dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSMutableArray *finalObjects = [NSMutableArray new];
    NSArray *currentObjects = [self objectsForEntity:entityName];
    for(NSDictionary *dictionary in dictionariesArray) {
        if(!dictionary[idCheck]) {
            DLog(@"ID Check: '%@', not found in dictionary: %@", idCheck, dictionary);
            continue;
        }
        NSManagedObject *object;
        NSArray *filteredObjects;
        if(isInteger) {
            filteredObjects = [currentObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %d", idCheck, [dictionary[idCheck] intValue]]];
        }
        else {
            filteredObjects = [currentObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"%K == %@", idCheck, dictionary[idCheck]]];
        }
        if(filteredObjects.count) {
            object = filteredObjects.firstObject;
        }
        else {
            object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
        }
        [object safeSetValuesForKeysWithDictionary:dictionary dateFormatter:dateFormatter];
        [finalObjects addObject:object];
    }    
    return finalObjects;
}

-(NSManagedObject *)updateObjectWithDictionary:(NSDictionary *)dictionary entityName:(NSString *)entityName idCheck:(NSString *)idCheck
{
    return [self updateObjectWithDictionary:dictionary entityName:entityName idCheck:idCheck isInteger:FALSE];
}

-(NSManagedObject *)updateObjectWithDictionary:(NSDictionary *)dictionary entityName:(NSString *)entityName idCheck:(NSString *)idCheck isInteger:(BOOL)isInteger
{
    if(!dictionary[idCheck]) {
        DLog(@"ID Check: '%@', not found in dictionary: %@", idCheck, dictionary);
        return nil;
    }
    NSManagedObject *object;
    NSArray *filteredObjects;
    if(isInteger) {
        filteredObjects = [self objectsWithPredicate:[NSPredicate predicateWithFormat:@"%K == %d", idCheck, [dictionary[idCheck] intValue]] entityName:entityName];
    }
    else {
        filteredObjects = [self objectsWithPredicate:[NSPredicate predicateWithFormat:@"%K == %@", idCheck, dictionary[idCheck]] entityName:entityName];
    }
    if(filteredObjects.count) {
        object = filteredObjects.firstObject;
    }
    else {
        object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    }
    [object safeSetValuesForKeysWithDictionary:dictionary];
    return object;
}

#pragma mark Saving

-(void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            DLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark Creating Model, Context & and PersistentStoreCoordinator

-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectModel) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSString *pathComponent = [NSString stringWithFormat:@"%@.sqlite", self.modelName];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:pathComponent];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES, NSPersistentStoreFileProtectionKey:@YES} error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

-(NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark Singleton

+(id)sharedBDGCoreData
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end



