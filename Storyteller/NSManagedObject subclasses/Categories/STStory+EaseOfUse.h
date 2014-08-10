//
//  STStory+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STStory.h"

@interface STStory (EaseOfUse)
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
+(STStory *)initWithName: (NSString *) name inContext:(NSManagedObjectContext *)context;

/**
 *  Finds a particular story within a particular core data context.
 *
 *  @param name    The name of the STStory that is to be found.
 *  @param context The context in which to search
 *
 *  @return A particular STStory instance if the name is found. Nil if there is no STStory with the specified name.
 */
+(STStory *)findStoryWithName: (NSString *)name inContext:(NSManagedObjectContext *)context;

/**
 *  Finds all the Stories within a particular context
 *
 *  @param context The context to search.
 *
 *  @return A NSArray of STStory objects that are in the specified context.
 */
+(NSArray *)findAllStoriesAscendinglyWithinContext: (NSManagedObjectContext *)context;
//-------------------------------------------------------------------------------------------

/**
 *  Adds a new scene and sets it to be the starting scene
 *
 *  @param scene The new scene to add to the scene list and set as the starting scene.
 */
-(void)setNewSceneToStartingScene:(STInteractiveScene *)scene;

/**
 *  Returns the starting scene as the appropriate instance of STInteractiveScene
 *
 *  @return Appropriate starting scene as an STInteractiveScene object.
 */
-(STInteractiveScene *)stInteractiveStartingScene;

/**
 *  Returns the currently editing scene as the appropriate instance of STInteractiveScene
 *
 *  @return Appropriate editing scene as an STInteractiveScene object.
 */
-(STInteractiveScene *)stInteractiveCurrentEditingScene;

/**
 *  Returns the total number of scene elements in the story
 *
 *  @return Total number of scene elements including media within a story. Useful for verification purposes.
 */
-(int)numberOfSceneElementsForCurrentStory;

@end
