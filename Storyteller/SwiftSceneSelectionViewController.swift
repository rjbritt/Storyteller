//
//  SwiftSceneSelectionViewController.swift
//  Storyteller
//
//  Created by Ryan Britt on 7/17/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//
// name to refactor to: STSelectSceneViewController

import UIKit

class SwiftSceneSelectionViewController:UIViewController
{
    enum SelectedSceneElementType
    {
        case Actor
        case Environment
        case Object
        case Text
    }
    
    //class properties
    
    //Any or all of these could be nil in which case there are no elements of a particular type.
    var sceneElementPathArray:[String]?
    var actorElementPathArray:[String]?
    var environmentElementPathArray:[String]?
    var objectElementPathArray:[String]?

    var currentSceneElementType = SelectedSceneElementType.Actor
    var sceneManagementDelegate:SceneManagementDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        
        //find the path to the resource dictionary
        let resourcePath = NSBundle.mainBundle().pathForResource("ImageResourceNames", ofType: "plist")
        //initialize the resource dictionary
        let resourcePathDictionary = NSDictionary(contentsOfFile: resourcePath)
        
        //Search through all the keys
        for key in resourcePathDictionary.allKeys
        {
            //put the appropriate objects into each array
            switch key as String
            {
            case "Actor":
                actorElementPathArray = resourcePathDictionary.objectForKey(key) as? [String]
            case "Environment":
                environmentElementPathArray = resourcePathDictionary.objectForKey(key) as? [String]
            case "Object":
                objectElementPathArray = resourcePathDictionary.objectForKey(key) as? [String]
            default:
                break
            }
        }
        
        sceneElementPathArray = actorElementPathArray
    }
    
}

extension SwiftSceneSelectionViewController:UICollectionViewDataSource
{

    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return sceneElementPathArray!.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        if let sceneElementPath = sceneElementPathArray
        {
            var currentImage = UIImage(named: sceneElementPath[indexPath.row])
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
            
        }

        return cell
        
    }
}

extension SwiftSceneSelectionViewController:UICollectionViewDelegate
{
    func collectionView(collectionView:UICollectionView!, didSelectItemAtIndexPath indexPath:NSIndexPath!)
    {
        let cell = self.collectionView(collectionView!, cellForItemAtIndexPath: indexPath)
        var currentImage:UIImage?
        
        if(cell.backgroundView.isMemberOfClass(UIImageView))
        {
            currentImage = (cell.backgroundView as UIImageView).image
        }
        
        if let sceneDelegate = sceneManagementDelegate
        {
            switch currentSceneElementType
                {
            case .Actor:
                sceneDelegate.addSceneElementWithImage(currentImage, ofType: "Actor")
            case .Environment:
                sceneDelegate.addSceneElementWithImage(currentImage, ofType: "Environment")
            case .Object:
                sceneDelegate.addSceneElementWithImage(currentImage, ofType: "Object")
            case .Text:
                sceneDelegate.addText()
            }
        }
        else {} //The edit Scene Delegate was not set before initiating this class. Create Error handling for outside caller.
        

        
    }

}

extension SwiftSceneSelectionViewController: UITabBarDelegate
{
    func tabBar(tabBar: UITabBar!, didSelectItem item: UITabBarItem!)
    {
        if let title = item.title
        {
            switch title
            {
                case "Actor":
                    currentSceneElementType = .Actor
                    sceneElementPathArray = actorElementPathArray
                case "Environment":
                    currentSceneElementType = .Environment
                    sceneElementPathArray = environmentElementPathArray
                case "Object":
                    currentSceneElementType = .Object
                    sceneElementPathArray = objectElementPathArray
                case "Media":
                    currentSceneElementType = .Text
                    sceneElementPathArray = ["Text"]
            default:
                break
            }
        }
        
        collectionView.reloadData()
    }
}
