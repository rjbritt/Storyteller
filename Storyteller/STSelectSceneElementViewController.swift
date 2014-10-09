//
//  STSelectSceneElementViewController
//  Storyteller
//
//  Created by Ryan Britt on 7/17/14.
//  Copyright (c) 2014 Ryan Britt. All rights reserved.
//
// refactor to: STSelectSceneElementViewController

import UIKit


class STSelectSceneElementViewController:UIViewController
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
        
        if let uitabBarItems = tabBar.items
        {
            tabBar.selectedItem = uitabBarItems[0] as? UITabBarItem;
        }
        
        //find the path to the resource dictionary
        let resourcePath = NSBundle.mainBundle().pathForResource("ImageResourceNames", ofType: "plist")
        //initialize the resource dictionary
        let resourcePathDictionary = NSDictionary(contentsOfFile: resourcePath!)
        
        let allkeys = resourcePathDictionary.allKeys
        //{ if let statement needed above for Xcode 6.1 beta. Not sure if permanent swift language change or not.
            for key in allkeys
            {
                //put the appropriate objects into each array
                let value = resourcePathDictionary.objectForKey(key) as? NSArray
                switch key as String
                {
                case "Actor":
                    actorElementPathArray = value as? [String]
                case "Environment":
                    environmentElementPathArray = value as? [String]
                case "Object":
                    objectElementPathArray = value as? [String]
                default:
                    break
                }

            }
        //}
        
        sceneElementPathArray = actorElementPathArray


    }
    
}

extension STSelectSceneElementViewController:UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sceneElementPathArray!.count
    }
    
    func collectionView(thisCollectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        if let sceneElementPath = sceneElementPathArray
        {
            let currentImage = UIImage(named: sceneElementPath[indexPath.row])
            switch currentSceneElementType
                {
            case .Actor,.Environment,.Object:
                cell.backgroundView = UIImageView(image: currentImage)
            case .Text:
                let textView = UITextView() //UITextView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                textView.text = "Text Box"
                textView.editable = false
                textView.userInteractionEnabled = false
                cell.backgroundView = textView
            }
            
        }
        return cell
        
    }
}

extension STSelectSceneElementViewController:UICollectionViewDelegate
{
    func collectionView(thisCollectionView: UICollectionView!,
           layout collectionViewLayout: UICollectionViewLayout!,
      sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
        
    {
        //Assign a default size
        var size = CGSizeMake(100, 100)
        
        if let sceneElementPath = sceneElementPathArray
        {
            let currentImage = UIImage(named: sceneElementPath[indexPath.row])

            switch currentSceneElementType
            {
            case .Actor,.Environment,.Object:
                //Change size to match the image
                size = currentImage.size
            default:
                break
            }
        }

        
        return size
    }
    
    
    func collectionView(collectionView:UICollectionView!, didSelectItemAtIndexPath indexPath:NSIndexPath!)
    {
        let cell = self.collectionView(collectionView!, cellForItemAtIndexPath: indexPath)
        var currentImage:UIImage?
        
        if let backgroundView = cell.backgroundView
        {
            if(backgroundView.isMemberOfClass(UIImageView))
            {
                currentImage = (cell.backgroundView as UIImageView).image
            }
        }
        
        //unwrap and check sceneManagementDelegate
        if let sceneDelegate = sceneManagementDelegate
        {
            switch currentSceneElementType
                {
            case .Actor:
                sceneDelegate.addSceneElementWithImage(currentImage, ofType: "Character")
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

extension STSelectSceneElementViewController: UITabBarDelegate
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
