//
//  STStory+EaseOfUse.h
//  Storyteller
//
//  Created by Ryan Britt on 5/25/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STStory.h"

@interface STStory (EaseOfUse)
+(STStory *)initWithName: (NSString *) name inContext:(NSManagedObjectContext *)context;
+(STStory *)findStoryWithName: (NSString *)name inContext:(NSManagedObjectContext *)context;
+(NSArray *)findAllStoriesWithinContext: (NSManagedObjectContext *)context;

-(void)setNewSceneToStartingScene:(STInteractiveScene *)scene;
-(STInteractiveScene *)startingSceneToSTInteractiveScene;
-(STInteractiveScene *)editingSceneToSTInteractiveScene;


@end
