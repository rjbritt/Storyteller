//
//  ViewController.swift
//  Storyteller
//
//  Created by RJBritt on 6/11/16.
//  Copyright © 2016 RyanBritt. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController:UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let skView = segue.destinationViewController.view as! SKView
        let size = skView.frame.size
        let conversionScene = UIKitConversionScene(size: size)
        conversionScene.backgroundColor = UIColor.blueColor()
        conversionScene.conversionViews = view.subviews.flatMap{$0 as? ConvertibleView}
        skView.presentScene(conversionScene)
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Landscape
    }
    override func shouldAutorotate() -> Bool {
        return true
    }

}
