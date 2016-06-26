//
//  MapPlistInterpreter.swift
//  Storyteller
//
//  Created by RJBritt on 6/25/16.
//  Copyright © 2016 RyanBritt. All rights reserved.
//

import Foundation
import SpriteKit

public class MapPListInterpreter {
    var tileMapNodes:[SKTileMapNode] = []
    
    init(fileName:String) {
        guard let rootDictionary = NSDictionary(contentsOfFile: fileName) else {return}
        for key in rootDictionary.allKeys  {
            let mapInfo = rootDictionary.value(forKey: key as! String)
            guard let tilemapNode = SKTileMapNode(fileNamed: mapInfo?.value(forKey: "tileMapName") as! String)
                else {return}
            tileMapNodes.append(tilemapNode)
        }
    }
}
