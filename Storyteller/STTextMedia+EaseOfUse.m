//
//  STTextMedia+EaseOfUse.m
//  Storyteller
//
//  Created by Ryan Britt on 6/11/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STTextMedia+EaseOfUse.h"
#import "STInteractiveScene+EaseOfUse.h"
#import "STStory+EaseOfUse.h"

@implementation STTextMedia (EaseOfUse)
+(CGRect) genericRectForTextFieldAtCenter:(CGPoint)center
{
    //Assumes center was set with the intention of a specific height and width
    int height = 300;
    int width = 300;
    
    CGPoint origin;
    origin.x = center.x - (width/2);
    origin.y = center.y - (height/2);
    
    return  CGRectMake(origin.x, origin.y, width, height);
}

+(STTextMedia *)initWithText:(NSString *)text withFontSize:(int)fontSize inContext:(NSManagedObjectContext *)context atCenter:(CGPoint)center
{
    STTextMedia *temp = [NSEntityDescription insertNewObjectForEntityForName:@"STTextMedia" inManagedObjectContext:context];
    temp.text = text;
    temp.fontSize = fontSize;
    temp.center = NSStringFromCGPoint(center);
    
    return temp;
}

+(STTextMedia *)findTextMediaWithText:(NSString *)text
                              inScene:(STInteractiveScene *)scene
                             andStory:(STStory *)story
                            inContext:(NSManagedObjectContext *)context
{
    STTextMedia *media;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"STTextMedia"];
    NSPredicate *textFilter = [NSPredicate predicateWithFormat:@"text == %@",text];
    NSPredicate *sceneFilter = [NSPredicate predicateWithFormat:@"belongingSceneOnly == %@", scene];
    NSPredicate *storyFilter = [NSPredicate predicateWithFormat:@"belongingSceneOnly.belongingStory == %@", story];
    
    NSPredicate *compoundPred = [NSCompoundPredicate  andPredicateWithSubpredicates:@[textFilter, sceneFilter, storyFilter]];
    
    request.predicate = compoundPred;
    
    NSArray *array = [context executeFetchRequest:request error:nil];
    
    //As long as there is an element that meets that criteria
    if(array.count > 0)
    {
        media = array[0];
    }
    
    return media;
}

-(CGPoint)centerPointCGPoint
{
    return CGPointFromString(self.center);
}
-(void)setCenterPoint:(CGPoint)point
{
    self.center = NSStringFromCGPoint(point);
}


@end
