//
//  STActor.m
//  Storyteller
//
//  Created by Ryan Britt on 4/8/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import "STActor.h"
#import "STInteractiveScene.h"


@implementation STActor

@dynamic belongingScene;

/**
 * initWithName:name withImage:image withTag:tag withinContext:context centeredAt:center
 * This is an easy way of initializing an STActor in order to obfuscate the NSEntity Description every time an STActor must be used.
 *
 * @param name The name of the STActor
 * @param image A UIImage of the STActor
 * @param tag An appropriate tag to differentiate the actor type
 * @param context The NSManagedObjectContext where this STActor is being added
 * @param center The desired center of the STActor in UIKit coordinates
 *
 * @return A properly configured STActor
 */

+(STActor *)initWithName: (NSString *) name withImage:(UIImage *)image withTag:(int) tag withinContext:(NSManagedObjectContext *)context centeredAt:(CGPoint) center
{
    STActor * temp = [NSEntityDescription insertNewObjectForEntityForName:@"STActor" inManagedObjectContext:context];
    temp.name = name;
    temp.image = UIImagePNGRepresentation(image);
    temp.tag = tag;
    temp.center = NSStringFromCGPoint(center);
    
    return temp;
}

@end
