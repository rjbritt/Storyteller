//
//  STInteractiveScene+.swift
//  Storyteller
//
//  Created by Ryan Britt on 8/12/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

import Foundation
import CoreData
extension STInteractiveScene
{
    /**
    This convenience method allows the class to call a class method which will
    instantiate a new STInteractiveScene within the designated 
    NSManagedObjectContext
    
    :param: name    The name of the new scene
    :param: context The context into which the new scene is to be inserted
    
    :returns: The newly initiated STInteractiveScene
    */
    class func initWithName(name:String, inContext context:NSManagedObjectContext) ->STInteractiveScene
    {
        var scene:STInteractiveScene = NSEntityDescription.insertNewObjectForEntityForName("STInteractiveScene", inManagedObjectContext:context) as STInteractiveScene
        
        scene.name = name
        
        return scene
    }
    
    /**
    This convenience class method allows the return of a particular named scene within a certain context.
    
    :param: name    The name of the scene to be found
    :param: context The context in which to search.
    
    :returns: An optional containing the correct scene if one was found, nil if not.
    */
    class func findSceneWithName(name:String, inContext context:NSManagedObjectContext) -> STInteractiveScene?
    {
        var foundScene:STInteractiveScene?
        
        let request = NSFetchRequest(entityName: "STInteractiveScene")
        let nameFilter = NSPredicate(format: "name == %@", argumentArray: [name])
        
        request.predicate = nameFilter
        
        let results = context.executeFetchRequest(request, error: nil)
     
        if(!results.isEmpty)
        {
            foundScene = results[0] as? STInteractiveScene
        }
        
        return foundScene
    }
    
    /**
    This is a default Environment name generator that is linked to a saved incremented value. This guarentees unique default names.
    
    :returns: A String representing the next Actor name.
    */
    func nextActorName() -> String
    {
        return String(format: "Actor%i", actorTagIncr++)
    }
    
    /**
    This is a default Environment name generator that is linked to a saved incremented value. This guarentees unique default names.
    
    :returns: A String representing the next Environment name.
    */
    func nextEnviroName() ->String
    {
        return String(format: "Environment%i", enviroTagIncr++)
    }
    
    /**
    This is a default Object name generator that is linked to a saved incremented value. This guarentees unique default names.
    
    :returns: A String representing the next Object name.
    */
    func nextObjectName() ->String
    {
        return String(format: "Object%i", objectTagIncr++)
    }
    
    
}
