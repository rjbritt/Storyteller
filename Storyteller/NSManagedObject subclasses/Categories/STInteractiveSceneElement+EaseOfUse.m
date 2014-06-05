//
//  STInteractiveSceneElement+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneElement+EaseOfUse.h"
#import "STActorSceneElement.h"
#import "STEnvironmentSceneElement.h"
#import "STObjectSceneElement.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"

@implementation STInteractiveSceneElement (EaseOfUse)

//Convienence Methods

-(CGPoint) centerPointCGPoint
{
    return CGPointFromString(self.center);
}

-(void) setCenterPoint:(CGPoint)point
{
    self.center = NSStringFromCGPoint(point);
}

-(UIImage *) getUIImageFromData
{
    return [UIImage imageWithData:self.image];
}

-(void) setImageDataFromUIImage: (UIImage *)image
{
    self.image = UIImagePNGRepresentation(image);
}


/**
 * initializeSceneElementType: withImage: withinContext: centeredAt:
 * This is an easy way of initializing an STActor in order to obfuscate the NSEntity Description every time an STActor must be used.
 *
 * @param name The name of the STActor
 * @param image A UIImage of the STActor
 * @param context The NSManagedObjectContext where this STActor is being added
 * @param center The desired center of the STActor in UIKit coordinates
 *
 * @return A properly configured STActor
 */

/**
 *  This is a factory method to easily initialize a scene element of a specific type.
 *
 *  @param elementType An element of the STInteractiveSceneElementType ENUM. Valid element types are 
 *  STInteractiveSceneElementTypeActor
 *  STInteractiveSceneElementTypeEnvironment
 *  STInteractiveSceneElementTypeObject
 *  
 *  @param name        The NSString name of the SceneElement
 *  @param image       The image (as a UIImage *)
 *  @param context     The NSManagedObjectContext that this element needs to be created in.
 *  @param center      The desired center of this Scene Element
 *
 *  @return The appropriate STInteractiveSceneElement properly initialized.
 */
+(STInteractiveSceneElement *)initializeSceneElementType:(STInteractiveSceneElementType)elementType
                                                withName:(NSString *)name
                                               withImage:(UIImage *)image
                                           withinContext:(NSManagedObjectContext *)context
                                              centeredAt:(CGPoint)center
{
    STInteractiveSceneElement *returnedElement;
    
    switch (elementType)
    {
        case STInteractiveSceneElementTypeActor:
        {
            STActorSceneElement * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STActorSceneElement" inManagedObjectContext:context];
            returnedElement = temp;
        }
            break;
        case STInteractiveSceneElementTypeEnvironment:
        {
            STEnvironmentSceneElement * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STEnvironmentSceneElement" inManagedObjectContext:context];
            returnedElement = temp;
        }
            break;
        case STInteractiveSceneElementTypeObject:
        {
            STObjectSceneElement * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STObjectSceneElement" inManagedObjectContext:context];
            returnedElement = temp;
        }
            break;
            
        default:
            break;
    }
    
    // If there was an error or if the SceneElementType was incorrect, this method will return a nil object.
    if(returnedElement)
    {
        returnedElement.name = name;
        [returnedElement setImageDataFromUIImage:image];
        [returnedElement setCenterPoint:center];
    }
    
    return returnedElement;
}

/**
 *  <#Description#>
 *
 *  @param elementType <#elementType description#>
 *  @param name        <#name description#>
 *  @param story       <#story description#>
 *  @param scene       <#scene description#>
 *  @param context     <#context description#>
 *
 *  @return <#return value description#>
 */
+(STInteractiveSceneElement *)findSceneElementOfType:(STInteractiveSceneElementType)elementType
                                            withName:(NSString *)name
                                             inStory:(STStory *)story
                                             inScene:(STInteractiveScene *)scene
                                           inContext:(NSManagedObjectContext *)context;
{
    STInteractiveSceneElement *returnedElement;
    NSFetchRequest *elementFetch;
    
    //Determine what element type to fetch.
    switch (elementType)
    {
        case STInteractiveSceneElementTypeActor:
        {
            elementFetch = [NSFetchRequest fetchRequestWithEntityName:@"STActorSceneElement"];
        }
            break;
        case STInteractiveSceneElementTypeEnvironment:
        {
            elementFetch = [NSFetchRequest fetchRequestWithEntityName:@"STEnvironmentSceneElement"];
        }
            break;
        case STInteractiveSceneElementTypeObject:
        {
            elementFetch = [NSFetchRequest fetchRequestWithEntityName:@"STObjectSceneElement"];

        }
            break;
            
        default:
            elementFetch = [NSFetchRequest fetchRequestWithEntityName:@"STInteractiveSceneElement"];

            break;
    }

    //Apply current name, scene, and story filters as predicates
    NSPredicate *currentNameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
    NSPredicate *currentSceneFilter = [NSPredicate predicateWithFormat:@"belongingScene.name == %@", scene.name];
    NSPredicate *currentStoryFilter = [NSPredicate predicateWithFormat:@"belongingScene.belongingStory.name == %@", story.name];
    
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[currentNameFilter, currentSceneFilter, currentStoryFilter]];
    
    [elementFetch setPredicate:compoundPredicate];
    NSArray * elementArray = [context executeFetchRequest:elementFetch error:nil];
    
    //As long as there is an element that meets that criteria
    if(elementArray.count > 0)
    {
        returnedElement = elementArray[0];
    }
    
    return returnedElement;
}


@end
