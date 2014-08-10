//
//  CoreData.h
//  
//
//  Created by Ryan Britt on 7/30/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <NSManagedObjectModel+KCOrderedAccessorFix.h>

@interface CoreData : NSObject

+(CoreData *)sharedInstance;

@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;

- (void)setupCoreData;
- (void)saveContext;

@end
