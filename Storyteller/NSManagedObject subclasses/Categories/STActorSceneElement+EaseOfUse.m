//
//  STActorSceneElement+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 5/31/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STActorSceneElement+EaseOfUse.h"
#import "STStory+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"

@implementation STActorSceneElement (EaseOfUse)
/**
 * initActorWithName: withImage: withinContext: centeredAt:
 * This is an easy way of initializing an STActor in order to obfuscate the NSEntity Description every time an STActor must be used.
 *
 * @param name The name of the STActor
 * @param image A UIImage of the STActor
 * @param context The NSManagedObjectContext where this STActor is being added
 * @param center The desired center of the STActor in UIKit coordinates
 *
 * @return A properly configured STActor
 */

+(STActorSceneElement *)initActorWithName: (NSString *) name withImage:(UIImage *)image withinContext:(NSManagedObjectContext *)context centeredAt:(CGPoint) center
{
    STActorSceneElement * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STActorSceneElement" inManagedObjectContext:context];
    temp.name = name;
    temp.image = UIImagePNGRepresentation(image);
    temp.center = NSStringFromCGPoint(center);
    return temp;
}

+(STActorSceneElement *)findActorSceneElementWithName:(NSString *)name
                                              inStory:(STStory *)story
                                              inScene:(STInteractiveScene *)scene
                                            inContext:(NSManagedObjectContext *)context;
{
    STActorSceneElement *temp;
    
    //Fetch the appropriate STActor
    NSFetchRequest *stActorFetch = [NSFetchRequest fetchRequestWithEntityName:@"STActorSceneElement"];
    
    NSPredicate *currentActorNameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
    NSPredicate *currentSceneFilter = [NSPredicate predicateWithFormat:@"belongingScene.name == %@", scene.name];
    NSPredicate *currentStoryFilter = [NSPredicate predicateWithFormat:@"belongingScene.belongingStory.name == %@", story.name];
    
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[currentActorNameFilter, currentSceneFilter, currentStoryFilter]];
    
    [stActorFetch setPredicate:compoundPredicate];
    NSArray * actorArray = [context executeFetchRequest:stActorFetch error:nil];
    
    //As long as there is an actor that meets that criteria
    if(actorArray.count > 0)
    {
        temp = actorArray[0];
    }
    
    return  temp;
    
}


@end
