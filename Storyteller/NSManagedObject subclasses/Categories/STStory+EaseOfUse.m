//
//  STStory+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"

@implementation STStory (EaseOfUse)

#pragma mark - Initialization

/**
 *  Initializes a new story entity within the required NSManagedObjectContext.
 *  This method assumes that the uniqueness of this name has been verified.
 *  All stories initialized this way are defaulted to unordered scenes
 *
 *  @param name    The name for which the STStory will be initiated
 *  @param context The context in which the STStory will be initiated
 *
 *  @return A new STStory class that has been properly initiated within its CoreData context
 */
+(STStory *)initWithName: (NSString *) name inContext:(NSManagedObjectContext *)context
{
    
    STStory *temp = [NSEntityDescription insertNewObjectForEntityForName:@"STStory" inManagedObjectContext:context];
    temp.isOrdered = NO;
    temp.name = name;
    
    return temp;
}


#pragma mark - Convenience Methods
/**
 *  This method is designed to help find a particular story within a particular core data context.
 *
 *  @param name    The name of the STStory that is to be found.
 *  @param context The context in which to search
 *
 *  @return A particular STStory instance if the name is found. Nil if there is no STStory with the specified name.
 */
+(STStory *)findStoryWithName: (NSString *)name inContext:(NSManagedObjectContext *)context
{
    STStory *foundStory;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STStory"];
    NSPredicate *thisStoryNameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setPredicate:thisStoryNameFilter];
    
    
    NSArray *allEntries = [context executeFetchRequest:request error:nil];
    if(allEntries.count > 0)
    {
        foundStory = allEntries[0]; //This is used in combination with the initWithName method to guarentee that there is only one story with a particular name.
    }
    
    //if there is no STStory with that name, then foundStory will remain initialized at nil and we can use this fact when calling this method.
    
    return foundStory;
}

/**
 *  This method finds all the Stories within a particular context
 *
 *  @param context The context to search.
 *
 *  @return A NSArray of STStory objects that are in the specified context.
 */
+(NSArray *)findAllStoriesAscendinglyWithinContext: (NSManagedObjectContext *)context
{
    NSArray *allStories;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STStory"];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    
    [request setSortDescriptors:@[sort]];
    allStories = [context executeFetchRequest:request error:nil];
    
    
    return allStories;
}
/**
 *  Adds a new scene and sets it to be the starting scene
 *
 *  @param scene The new scene to add to the scene list and set as the starting scene.
 */
-(void)setNewSceneToStartingScene:(STInteractiveScene *)scene
{
    [self addInteractiveSceneListObject:scene];
    self.startingSceneIndex = (int) [self.interactiveSceneList indexOfObject:scene];
}

/**
 *  Returns the starting scene as the appropriate instance of STInteractiveScene
 *
 *  @return Appropriate starting scene as an STInteractiveScene object.
 */
-(STInteractiveScene *)stInteractiveStartingScene
{
    return self.interactiveSceneList[self.startingSceneIndex];
}

/**
 *  Returns the currently editing scene as the appropriate instance of STInteractiveScene
 *
 *  @return Appropriate editing scene as an STInteractiveScene object.
 */
-(STInteractiveScene *)stInteractiveCurrentEditingScene
{
    return self.interactiveSceneList[self.editingSceneIndex];
}

/**
 *  Returns the total number of scene elements in the story
 *
 *  @return Total number of scene elements including media within a story. Useful for verification purposes.
 */
-(int)numberOfSceneElementsForCurrentStory
{
    int sum = 0;
    for (STInteractiveScene * scene in self.interactiveSceneList)
    {
        sum += scene.actorSceneElementList.count;
        sum += scene.environmentSceneElementList.count;
        sum += scene.objectSceneElementList.count;
        sum += scene.sceneMedia.count;
    }
    
    return sum;
}

@end
