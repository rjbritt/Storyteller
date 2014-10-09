//
//  STInteractiveSceneElement+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STInteractiveSceneElement.h"


@class STStory;
@class STInteractiveScene;

typedef NS_ENUM(NSInteger, STInteractiveSceneElementType)
{
    STInteractiveSceneElementTypeCharacter= 1000,
    STInteractiveSceneElementTypeEnvironment,
    STInteractiveSceneElementTypeObject,
};


@interface STInteractiveSceneElement (EaseOfUse)

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

+(STInteractiveSceneElement *)initializeSceneElementType:(STInteractiveSceneElementType)
                                    elementType withName:(NSString *)name
                                               withImage:(UIImage *)image
                                           withinContext:(NSManagedObjectContext *)context
                                              centeredAt:(CGPoint)center;

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

/**
 *  Convenience Method to return the stored NSString center as a CGPoint
 *
 *  @return Center of the SceneElement as a CGPoint
 */
-(CGPoint) centerPointCGPoint;

/**
 *  Convenience Method to set the stored NSString center from a CGPoint
 *
 *  @param point The CGPoint to set as center
 */
-(void) setCenterPoint:(CGPoint)point;

/**
 *  Convenience method to return the NSData image as a UIImage
 *
 *  @return UIImage representation of the NSData image
 */
-(UIImage *) getUIImageFromData;

/**
 *  Convenience method to set the NSData image from a UIImage
 *
 *  @param image the UIImage to set as the NSData
 */
-(void) setImageDataFromUIImage: (UIImage *)image;

@end
