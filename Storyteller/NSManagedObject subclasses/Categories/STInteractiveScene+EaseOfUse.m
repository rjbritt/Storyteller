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

-(NSString *)nextActorName
{
    NSString *temp = [NSString stringWithFormat:@"Actor%i",(int) self.actorTagIncr];
    self.actorTagIncr ++;
    return temp;
}

-(NSString *)nextEnviroName
{
    NSString *temp = [NSString stringWithFormat:@"Environment%i",(int) self.enviroTagIncr];
    self.enviroTagIncr ++;
    return temp;
}

-(NSString *)nextObjectName
{
    NSString *temp = [NSString stringWithFormat:@"Object%i",(int) self.objectTagIncr];
    self.objectTagIncr ++;
    return temp;
}
@end
