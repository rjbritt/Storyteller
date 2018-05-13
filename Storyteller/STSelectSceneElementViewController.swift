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
    
    //Any or all of these could be empty in which case there are no elements of a particular type.
    var sceneElementPathArray:NSArray = []
    var actorElementPathArray:NSArray = []
    var environmentElementPathArray:NSArray = []
    var objectElementPathArray:NSArray = []

    var currentSceneElementType = SelectedSceneElementType.Actor
    @objc var sceneManagementDelegate:SceneManagementDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        
        if let uitabBarItems = tabBar.items
        {
            tabBar.selectedItem = uitabBarItems[0] as UITabBarItem;
        }
        
        //find the path to the resource dictionary
        let resourcePath = Bundle.main.path(forResource: "ImageResourceNames", ofType: "plist")
        //initialize the resource dictionary
        let resourcePathDictionary = NSDictionary(contentsOfFile: resourcePath!)
        
        actorElementPathArray = (resourcePathDictionary?.object(forKey: "Actor") as! NSArray)
        environmentElementPathArray = (resourcePathDictionary?.object(forKey: "Environment") as! NSArray)
        objectElementPathArray = (resourcePathDictionary?.object(forKey: "Object") as! NSArray)
        
        
//        let allkeys = resourcePathDictionary.allKeys as [String]
//        //{// if let statement needed above for Xcode 6.1 beta. Not sure if permanent swift language change or not.
//            for key in allkeys
//            {
//                //put the appropriate objects into each array
//                let value = resourcePathDictionary.objectForKey(key) as [String]
//                switch key
//                {
//                case "Actor":
//                    actorElementPathArray = value
//                case "Environment":
//                    environmentElementPathArray = value
//                case "Object":
//                    objectElementPathArray = value
//                default:
//                    break
//                }
//
//            }
//        //}
        
        sceneElementPathArray = actorElementPathArray


    }
    
}

extension STSelectSceneElementViewController:UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sceneElementPathArray.count;
    }
    
    func collectionView(_ thisCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        if sceneElementPathArray.count > 0
        {
            let currentImage = UIImage(named:sceneElementPathArray[indexPath.row] as! String)
            switch currentSceneElementType
                {
            case .Actor,.Environment,.Object:
                cell.backgroundView = UIImageView(image: currentImage)
            case .Text:
                let textView = UITextView() //UITextView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                textView.text = "Text Box"
                textView.isEditable = false
                textView.isUserInteractionEnabled = false
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
        var size = CGSize(width:100, height:100)
        
        //if the scene elementpath contains a valid UIImage name, create it, and set the collectionViewItem size to its size.
        if let currentImage = UIImage(named: sceneElementPathArray[indexPath.row] as! String)
        {
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
    
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath)
        var currentImage:UIImage?
        
        if let backgroundView = cell.backgroundView
        {
            if(backgroundView is UIImageView)
            {
                currentImage = (cell.backgroundView as! UIImageView).image
            }
        }
        
        //unwrap and check sceneManagementDelegate
        if let sceneDelegate = sceneManagementDelegate
        {
            switch currentSceneElementType
                {
            case .Actor:
                sceneDelegate.addSceneElement(with: currentImage, ofType: "Character")
            case .Environment:
                sceneDelegate.addSceneElement(with: currentImage, ofType: "Environment")
            case .Object:
                sceneDelegate.addSceneElement(with: currentImage, ofType: "Object")
            case .Text:
                sceneDelegate.addText()
            }
        }
        else {} //The edit Scene Delegate was not set before initiating this class. Create Error handling for outside caller.
        

        
    }

}

extension STSelectSceneElementViewController: UITabBarDelegate
{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
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
