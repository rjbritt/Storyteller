//
//  UIKitConversionScene.swift
//  UIKitToSpriteKit
//
//  Created by RJBritt on 6/10/16.
//  Copyright © 2016 RyanBritt. All rights reserved.
//

import UIKit
import SpriteKit

public class UIKitConversionScene: SKScene {
    public var conversionViews:[ConvertibleView]?
    
    override public func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        configureViewsToNodes()
    }
    
    private func configureViewsToNodes() {
        guard let conversionViews = conversionViews else {return}
        for conversionView in conversionViews {
            guard let node = conversionView.node else {return}
            node.name = conversionView.convertibleViewName
            node.position = convertPointFromView(conversionView.view.center)
            addChild(node)
        }
    }
}
