//
//  STInteractiveScene+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveScene.h"

@interface STInteractiveScene (EaseOfUse)
/**
 *  Designated Initializer that allows the class to call a class method which will instantiate a new STInteractiveScene with
 *  the designated NSManagedObjectContext
 *
 *  @param name    The name of the new scene
 *  @param context The context into which the new scene is to be inserted
 *
 *  @return The newly initiated STInteractiveScene
 */
+(STInteractiveScene *)initWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

/**
 *  Locates a particular named scene within a certain context.
 *
 *  @param name    The name of the scene to be found
 *  @param context The context in which to search.
 *
 *  @return An element of STInteractiveScene if there is an instance with that name, Nil if not.
 */
+(STInteractiveScene *)findSceneWithName:(NSString *)name inContext:(NSManagedObjectContext *)context;

/**
 *  A default Actor name generator that is linked to a saved incremented value. This guarentees unique default names.
 *
 *  @return A NSString representing the next Actor name.
 */
-(NSString *)nextCharacterElementName;

/**
 *  A default Environment name generator that is linked to a saved incremented value. This guarentees unique default names.
 *
 *  @return A NSString representing the next Environment name.
 */
-(NSString *)nextEnviroElementName;

/**
 *  A default Object name generator that is linked to a saved incremented value. This guarentees unique default names.
 *
 *  @return A NSString representing the next Object name.
 */
-(NSString *)nextObjectElementName;


@end
