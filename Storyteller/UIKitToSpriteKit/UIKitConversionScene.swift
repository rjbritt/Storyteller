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
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        configureViewsToNodes()
    }
    
    private func configureViewsToNodes() {
        guard let conversionViews = conversionViews else {return}
        for conversionView in conversionViews {
            guard let node = conversionView.node else {return}
            node.name = conversionView.convertibleViewName
            node.position = convertPoint(fromView: conversionView.view.center)
            addChild(node)
        }
    }
}
