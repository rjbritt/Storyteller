//
//  SwiftSceneSelectionViewController.swift
//  Storyteller
//
//  Created by Ryan Britt on 7/17/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//

import UIKit

class SwiftSceneSelectionViewController:UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UITabBarDelegate
{
    enum SelectedSceneElementType
    {
        case Actor
        case Environment
        case Object
        case Text
    }
    
    //class properties
    var sceneElementPathArray = ["Actor","Actor 1", "Actor 2"]
    var currentSceneElementType = SelectedSceneElementType.Actor
    var editSceneDelegate:STEditSceneViewController?

    @IBOutlet var collectionView: UICollectionView
    @IBOutlet var tabBar: UITabBar
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        var currentImage = UIImage(named: sceneElementPathArray[indexPath.row])
        switch currentSceneElementType
        {
            case .Actor,.Environment,.Object:
                cell.backgroundView = UIImageView(image: currentImage)
            case .Text:
                let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                textView.text = "Text Box"
                textView.editable = false
                textView.userInteractionEnabled = false
                cell.backgroundView = textView
        }
        
        return cell

    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return sceneElementPathArray.count
    }
    
    func tabBar(tabBar: UITabBar!, didSelectItem item: UITabBarItem!)
    {
        switch item.title as NSString
        {
            case "Actor":
            currentSceneElementType = .Actor
            sceneElementPathArray = ["Actor", "Actor 2", "Actor 3"]
            case "Environment":
            currentSceneElementType = .Environment
            sceneElementPathArray = ["Environment", "Environment 2", "Environment3"]
            case "Object":
            currentSceneElementType = .Object
            sceneElementPathArray = ["Object", "Object 2", "Object 3"]
            default:
            currentSceneElementType = .Text
        }
        
        collectionView.reloadData()
    }

    func collectionView(collectionView:UICollectionView!, didSelectItemAtIndexPath indexPath:NSIndexPath!)
    {
        let cell = self.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
        var currentImage:UIImage?
        
        if(cell.backgroundView.isMemberOfClass(UIImage))
        {
            currentImage = (cell.backgroundView as UIImageView).image
        }
        switch currentSceneElementType
            {
        case .Actor:
            editSceneDelegate?.showElementSelect(nil)
            editSceneDelegate?.addActorSceneElementWithImage(currentImage)
        case .Environment:
            editSceneDelegate?.showElementSelect(nil)
            editSceneDelegate?.addEnvironmentSceneElementWithImage(currentImage)
        case .Object:
            editSceneDelegate?.showElementSelect(nil)
            editSceneDelegate?.addObjectSceneElementWithImage(currentImage)
        case .Text:
            editSceneDelegate?.showElementSelect(nil)
            editSceneDelegate?.addTextButton(nil)
        }
        
    }

    
}
