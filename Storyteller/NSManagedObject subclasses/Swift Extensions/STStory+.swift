//
//  STStory+.swift
//  Storyteller
//
//  Created by Ryan Britt on 8/15/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

import Foundation
import CoreData

extension STStory
{
    class func initWithName(name:String,
                inContext context:NSManagedObjectContext) -> STStory
    {
        var story = NSEntityDescription.insertNewObjectForEntityForName("STStory", inManagedObjectContext:context) as STStory
        
        story.name = name
        story.isOrdered = false
        
        return story
    }
    
    class func findStoryWithName(name:String, inContext context:NSManagedObjectContext) ->STStory?
    {
        var foundStory:STStory?
        let request = NSFetchRequest(entityName: "STStory")
        let thisStoryNameFilter = NSPredicate(format: "name == %@", argumentArray: [name])
        request.predicate = thisStoryNameFilter
        
        let allEntries = context.executeFetchRequest(request, error: nil)
        if(!allEntries.isEmpty)
        {
            foundStory = allEntries[0] as? STStory
        }
        
        return foundStory
    }
    
    class func findAllStoriesAscendinglyWithinContext(context:NSManagedObjectContext) -> [STStory]
    {
        let request = NSFetchRequest(entityName: "STStory")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        return context.executeFetchRequest(request, error: nil) as [STStory]
    }
    
    func setNewSceneToStartingScene(scene:STInteractiveScene)
    {
    }
    
}
