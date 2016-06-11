//
//  ConvertibleUIButton.swift
//  UIKitToSpriteKit
//
//  Created by RJBritt on 6/10/16.
//  Copyright © 2016 RyanBritt. All rights reserved.
//

import UIKit
import SpriteKit

public class ConvertibleButton:UIButton, ConvertibleView {
    public var convertibleViewName: String?
    public var node: SKNode?
    public var view: UIView!
    
    @IBInspectable var spriteImage:UIImage? {
        didSet {
            guard let sprite = spriteImage else {return}
            self.node = SKSpriteNode(texture: SKTexture(image: sprite))
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        view = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view = self

    }
}