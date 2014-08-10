//
//  STTextMedia+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 6/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STTextMedia.h"

@class STInteractiveScene;
@class STStory;

@interface STTextMedia (EaseOfUse)

/**
 *  Initializes a new STTextMedia entity from core data with the appropriate text and fontsize in the correct context with a particular center.
 *
 *  @param text     The text to populate the STTextMedia entity with.
 *  @param fontSize The fontsize to save for the STTextMedia.
 *  @param context  The core data context to save the entity in.
 *  @param center   The center for the STTextMedia
 *
 *  @return A properly configured STTextMedia instance.
 */
+(STTextMedia *)initWithText:(NSString *)text
                withFontSize:(int)fontSize
                   inContext:(NSManagedObjectContext *)context
                    atCenter:(CGPoint)center;

/**
 *  Finds a STTextMedia entity with a particular text in a
 *  particular scene,story, and core data context.
 *
 *  @param text    Text of the STTextMedia object to find.
 *  @param scene   Scene of the needed STTextMedia
 *  @param story   Story of the needed STTextmedia
 *  @param context Context of the needed STTextMedia.
 *
 *  @return A STTextMedia with the requested information. No logic currently exists if there are two STTextMedia entities with the same text but different information.
 *  will need to implement isEqual Method.
 */
+(STTextMedia *)findTextMediaWithText:(NSString *)text
                              inScene:(STInteractiveScene *)scene
                             andStory:(STStory *)story
                            inContext:(NSManagedObjectContext *)context;

/**
 *  The center property is stored as a NSString. This method converts it to a CGPoint before returning it.
 *
 *  @return The stored center value as a CGPoint.
 */
-(CGPoint)centerPointCGPoint;

/**
 *  The center property is stored as a NSString. This method allows a user to input
 *  a CGPoint and abstracts the conversion to a NSString before it saves the center value.
 *
 *  @param point CGPoint representing the center of the text field within its parent view.
 */
-(void)setCenterPoint:(CGPoint)point;



@end
