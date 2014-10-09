//
//  STInteractiveScene+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveScene+EaseOfUse.h"

@implementation STInteractiveScene (EaseOfUse)

#pragma mark - Convenience Methods

/**
 *  This convenience method allows the class to call a class method which will instantiate a new STInteractiveScene withi
 *  the designated NSManagedObjectContext
 *
 *  @param name    The name of the new scene
 *  @param context The context into which the new scene is to be inserted
 *
 *  @return The newly initiated STInteractiveScene
 */
+(STInteractiveScene *)initWithName:(NSString *)name inContext:(NSManagedObjectContext *)context
{
    STInteractiveScene * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STInteractiveScene" inManagedObjectContext:context];
    temp.name = name;
    return temp;
}

/**
 *  This convenience class method allows the return of a particular named scene within a certain context.
 *
 *  @param name    The name of the scene to be found
 *  @param context The context in which to search.
 *
 *  @return An element of STInteractiveScene if there is an instance with that name, Nil if not.
 */
+(STInteractiveScene *)findSceneWithName:(NSString *)name inContext:(NSManagedObjectContext *)context
{
    STInteractiveScene *foundScene;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STInteractiveScene"];
    NSPredicate *nameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setPredicate:nameFilter];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    if(results.count > 0) // If there are no found results, this method will return nil which can be used as an advantage.
    {
        foundScene = results[0];
    }
    
    return foundScene;
}



#pragma mark - Utility Methods

/**
 *  The is a default Actor name generator that is linked to a saved incremented value. This guarentees unique default names.
 *
 *  @return A NSString representing the next Actor name.
 */
-(NSString *)nextCharacterElementName
{
    NSString *temp = [NSString stringWithFormat:@"Actor%i",(int) self.actorTagIncr];
    self.actorTagIncr ++;
    return temp;
}

/**
 *  The is a default Environment name generator that is linked to a saved incremented value. This guarentees unique default names.
 *
 *  @return A NSString representing the next Environment name.
 */
-(NSString *)nextEnviroElementName
{
    NSString *temp = [NSString stringWithFormat:@"Environment%i",(int) self.enviroTagIncr];
    self.enviroTagIncr ++;
    return temp;
}

/**
 *  The is a default Object name generator that is linked to a saved incremented value. This guarentees unique default names.
 *
 *  @return A NSString representing the next Object name.
 */
-(NSString *)nextObjectElementName
{
    NSString *temp = [NSString stringWithFormat:@"Object%i",(int) self.objectTagIncr];
    self.objectTagIncr ++;
    return temp;
}
@end
