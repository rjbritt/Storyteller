//
//  STInteractiveSceneDataSource.h
//  Storyteller
//
//  Created by Ryan Britt on 3/29/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STInteractiveSceneDataSource <NSObject>
@property NSMutableArray *actors;
@property NSMutableArray *environment;

//This is slightyly modified copy from MyGame. Must change types
typedef NS_ENUM(NSInteger, STInteractiveSceneDataType)
{
    STInteractiveSceneDataTypePlayableCharacter = 1000,
    STInteractiveSceneDataTypeNonPlayableCharacter,
    STInteractiveSceneDataTypeSolidEnvironment
    
};


@end
