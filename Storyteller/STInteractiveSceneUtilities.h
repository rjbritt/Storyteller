//
//  STInteractiveSceneUtilities.h
//  Storyteller
//
//  Created by Ryan Britt on 4/6/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STInteractiveSceneUtilities : NSObject

//This is slightly modified copy from MyGame. Must change types
typedef NS_ENUM(NSInteger, STInteractiveSceneDataType)
{
    STInteractiveSceneDataTypePlayableCharacter = 1000,
    STInteractiveSceneDataTypeNonPlayableCharacter,
    STInteractiveSceneDataTypeSolidEnvironment,
    STInteractiveSceneDataTypeObject
    
};

@end
