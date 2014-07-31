//
//  CoreData.m
//  
//
//  Created by Ryan Britt on 7/30/14.
//
//

#import "CoreData.h"

@implementation CoreData


#pragma mark - Files
NSString *storeFilename = @"InteractiveSceneDataModel";

#pragma mark - Paths

- (NSString *)applicationDocumentsDirectory
{
    
#if DEBUG
    NSLog(@"Running %@ '%@'", self.class,NSStringFromSelector(_cmd));
#endif
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
}

- (NSURL *)applicationStoresDirectory
{
#if DEBUG
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
#endif
    
    //Determine Current directory store for this application
    NSURL *storesDirectory =
    [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
     URLByAppendingPathComponent:@"CoreDataStores"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //Determine whether or not there is already a filestore for this core data implementation
    if (![fileManager fileExistsAtPath:[storesDirectory path]])
    {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES
                                   attributes:nil
                                        error:&error])
        {
            //successful directory creation
#if DEBUG
            NSLog(@"Successfully created Stores directory");
#endif
        }
        else
        {
            NSLog(@"FAILED to create Stores directory: %@", error);
        }
    }
    
    return storesDirectory;
}

/**
 * storeURL
 * This gives the data store URL for the core data helper
 *
 * @return URL with appended core data model name
 */
- (NSURL *)storeURL
{
#if DEBUG
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
#endif
    return [[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}

#pragma mark - SETUP

+(CoreData *)sharedInstance
{
    static CoreData *_sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CoreData alloc]init];
    });
    
    return _sharedInstance;
}

-(id)initialInit
{
    /* NOTE:
     The model can also be initiated using an explicit managed model specification similar to
     _model = [[NSManagedObjectModel alloc] initWithContentsOfURL: [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"]];
     What are the consequences about having/needing multiple core data models and simply merging the bundles using this method. This may need investigation later.
     For now, simply merging the bundles looks like it will provide anything necessary.
     */
    
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    [_model kc_generateOrderedSetAccessors];
    
    _coordinator = [[NSPersistentStoreCoordinator alloc]
                    initWithManagedObjectModel:_model];
    _context = [[NSManagedObjectContext alloc]
                initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
}


- (id)init
{
#if DEBUG
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
#endif
    if (CoreData.sharedInstance)
    {
        self = CoreData.sharedInstance;
    }
    else
    {
        self = [super init];
        
        if(self)
        {
            [self initialInit];
        }
    }
    return self;
}

- (void)loadStore
{
# if DEBUG
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
#endif
    
    if (!_store) // as long as the store hasn't been loaded, load the persistent store.
    {
        NSError *error;
        _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                            configuration:nil
                                                      URL:[self storeURL]
                                                  options:nil error:&error];
        
        if (!_store)
        {
#warning Replace this implementation with code to handle the error in loading the persistent store appropriately
            /*
             
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
             
             
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             
             */
            
            NSLog(@"Failed to add store. Error: %@", error);
            abort();
        }
        else
        {
            
#if DEBUG
            NSLog(@"Successfully added store: %@", _store);
#endif
        }
        
    }
    else // Don't load store if it's already loaded
    {
        return;
    }
    
}

- (void)setupCoreData
{
#if DEBUG
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
#endif
    
    [self loadStore];
}

#pragma mark - Saving

- (void)saveContext
{
# if DEBUG
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
#endif
    
    if ([_context hasChanges])
    {
        NSError *error;
        if ([_context save:&error])
        {
            NSLog(@"_context SAVED changes to persistent store");
        }
        else
        {
            NSLog(@"Failed to save _context: %@", error);
        }
    }
    else
    {
        NSLog(@"SKIPPED _context save, there are no changes!");
    }
}

@end
