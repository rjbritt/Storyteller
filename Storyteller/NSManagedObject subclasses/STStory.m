//
//  STStory.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STStory.h"
#import "STInteractiveScene.h"


@implementation STStory

@dynamic name;
@dynamic interactiveSceneList;
@dynamic storyMedia;


/**
 *  Initializes a new story within the required NSManagedObjectContext.
 *  This method assumes that the uniqueness of this name has been verified.
 *
 *  @param name    The name for which the STStory will be initiated
 *  @param context The context in which the STStory will be initiated
 *
 *  @return A new STStory class that has been properly initiated within its CoreData context
 */
+(STStory *)initWithName: (NSString *) name inContext:(NSManagedObjectContext *)context
{
    
    STStory *temp = [NSEntityDescription insertNewObjectForEntityForName:@"STStory" inManagedObjectContext:context];
    temp.name = name;
    
    return temp;
}

/**
 *  This method is designed to help find a particular story within a particular core data context.
 *
 *  @param name    The name of the STStory that is to be found.
 *  @param context The context in which to search
 *
 *  @return A particular STStory instance if the name is found. Nil if there is no STStory named that.
 */
+(STStory *)findStoryWithName: (NSString *)name inContext:(NSManagedObjectContext *)context
{
    STStory *foundStory;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STStory"];
    NSPredicate *thisStoryNameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setPredicate:thisStoryNameFilter];
    
    
    NSArray *allEntries = [context executeFetchRequest:request error:nil];
    if([allEntries count] > 0)
    {
        foundStory = allEntries[0]; //This is used in combination with the initWithName method to guarentee that there is only one story with a particular name.
    }
    
    //if there is no STStory with that name, then foundStory will remain initialized at nil and we can use this fact when calling this method.
    
    return foundStory;
}



@end
