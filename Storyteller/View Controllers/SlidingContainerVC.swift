//
//  SlidingContainerVC.swift
//  Storyteller
//
//  Created by RJBritt on 6/12/16.
//  Copyright © 2016 RyanBritt. All rights reserved.
//

import UIKit



class SlidingContainerVC: SlideMenuController {
    @IBInspectable var mainVcId: String?
    @IBInspectable var leftVcId: String?
    @IBInspectable var rightVcId: String?

    override func viewDidLoad() {
        /* If the IBInspectables are set, attempt to set all VCs through Storyboard instantiation */
        if let mainId = mainVcId {
            mainViewController = storyboard?.instantiateViewControllerWithIdentifier(mainId)
        }
        if let leftId = leftVcId {
            leftViewController = storyboard?.instantiateViewControllerWithIdentifier(leftId)
            SlideMenuOptions.leftViewWidth = self.view.frame.width / 2.0
            addLeftGestures()
        }
        if let rightId = rightVcId {
            rightViewController = storyboard?.instantiateViewControllerWithIdentifier(rightId)
            SlideMenuOptions.rightViewWidth = self.view.frame.width / 2.0
            addRightGestures()
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
