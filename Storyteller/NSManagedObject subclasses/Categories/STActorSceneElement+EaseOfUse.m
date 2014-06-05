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


//+(STActorSceneElement *)findActorSceneElementWithName:(NSString *)name
//                                              inStory:(STStory *)story
//                                              inScene:(STInteractiveScene *)scene
//                                            inContext:(NSManagedObjectContext *)context
//{
//    STActorSceneElement *temp;
//    
//    //Fetch the appropriate STActor
//    NSFetchRequest *stActorFetch = [NSFetchRequest fetchRequestWithEntityName:@"STActorSceneElement"];
//    
//    NSPredicate *currentActorNameFilter = [NSPredicate predicateWithFormat:@"name == %@", name];
//    NSPredicate *currentSceneFilter = [NSPredicate predicateWithFormat:@"belongingScene.name == %@", scene.name];
//    NSPredicate *currentStoryFilter = [NSPredicate predicateWithFormat:@"belongingScene.belongingStory.name == %@", story.name];
//    
//    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[currentActorNameFilter, currentSceneFilter, currentStoryFilter]];
//    
//    [stActorFetch setPredicate:compoundPredicate];
//    NSArray * actorArray = [context executeFetchRequest:stActorFetch error:nil];
//    
//    //As long as there is an actor that meets that criteria
//    if(actorArray.count > 0)
//    {
//        temp = actorArray[0];
//    }
//    
//    return  temp;
//    
//}


@end
