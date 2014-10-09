//
//  STInteractiveSceneElement+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STManagedObjectImportAll.h"

@implementation STInteractiveSceneElement (EaseOfUse)

#pragma mark - Convenience Methods

/**
 *  Convenience Method to return the stored NSString center as a CGPoint
 *
 *  @return Center of the SceneElement as a CGPoint
 */
-(CGPoint) centerPointCGPoint
{
    return CGPointFromString(self.center);
}


/**
 *  Convenience Method to set the stored NSString center from a CGPoint
 *
 *  @param point The CGPoint to set as center
 */
-(void) setCenterPoint:(CGPoint)point
{
    self.center = NSStringFromCGPoint(point);
}

/**
 *  Convenience method to return the NSData image as a UIImage
 *
 *  @return UIImage representation of the NSData image
 */
-(UIImage *) getUIImageFromData
{
    return [UIImage imageWithData:self.image];
}

/**
 *  Convenience method to set the NSData image from a UIImage
 *
 *  @param image the UIImage to set as the NSData
 */
-(void) setImageDataFromUIImage: (UIImage *)image
{
    self.image = UIImagePNGRepresentation(image);
}

#pragma mark - Factory and superclass Methods
/**
 *  This is a factory method to easily initialize a scene element of a specific type.
 *
 *  @param elementType An element of the STInteractiveSceneElementType ENUM. Valid element types are 
 *  STInteractiveSceneElementTypeCharacter
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
        case STInteractiveSceneElementTypeCharacter:
        {
            STCharacterSceneElement * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STCharacterSceneElement" inManagedObjectContext:context];
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
 *  This convenience method allows the searching of any particular scene element of a certain name within a particular story
 *  and name.
 *
 *  @param elementType The STInteractiveSceneElementType that is going to be found and returned
 *  @param name        The Name of the STInteractiveSceneElement
 *  @param story       The Story that the STInteractiveSceneElement is in
 *  @param scene       The Scene that the STInteractiveSceneElement is in
 *  @param context     The NSManagedObjectContext to look for the STInteractiveSceneElement in
 *
 *  @return A particular scene element matching the search parameters. nil if not found.
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
        case STInteractiveSceneElementTypeCharacter:
        {
            elementFetch = [NSFetchRequest fetchRequestWithEntityName:@"STCharacterSceneElement"];
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
            //Will look for any STInteractiveSceneElement
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
