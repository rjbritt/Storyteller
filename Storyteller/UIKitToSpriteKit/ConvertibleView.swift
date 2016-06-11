//
//  ConvertibleUIView.swift
//  UIKitToSpriteKit
//
//  Created by RJBritt on 6/10/16.
//  Copyright © 2016 RyanBritt. All rights reserved.
//

import UIKit
import SpriteKit


public protocol ConvertibleView {
    var convertibleViewName:String? {get set}
    var node:SKNode? {get set}
    var view:UIView! {get}
}
