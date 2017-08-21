//
//  NextViewController.swift
//  mybook
//
//  Created by Intern on 01/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON
import FirebaseAuth

class NextViewController: UIViewController, UICollectionViewDelegate ,UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    var userPhotos:NSArray?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserDefaults.standard.set(1, forKey: "View")
        if let _ = FBSDKAccessToken.current()
        {
            fetchListOfUserPhotos()
        }
    }
    
    func fetchListOfUserPhotos()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/photos", parameters: ["fields":"picture"] )
        graphRequest.start(completionHandler:{ (connection, result, error) -> Void in
            if ((error) != nil)
            {
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let fbResult:[String:AnyObject] = result as! [String : AnyObject]
                self.userPhotos = fbResult["data"] as! NSArray?
                self.collectionView.reloadData()
            }
        })
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var returnValue = 0
        if let userPhotosObject = self.userPhotos
        {
            returnValue = userPhotosObject.count
        }
         return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let userPhotoObject = self.userPhotos![indexPath.row] as! NSDictionary
        let userPhotoUrlString = userPhotoObject.value(forKey: "picture") as! String
        let imageUrl:URL = URL(string: userPhotoUrlString)!
        DispatchQueue.global(qos: .userInitiated).async
            {
                let imageData:Data = try! Data(contentsOf: imageUrl)
                DispatchQueue.main.async
                    {
                        let image = UIImage(data: imageData)
                        myCell.image.image = image
                }
        }
       return myCell
    }
    
    var pass = UIImage(named: "")
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        pass = cell.image.image!
        performSegue(withIdentifier: "Segue", sender: self)}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "Segue"
        {
            if let viewController = segue.destination as? ViewController1
            {
                viewController.Value1 = pass
                
            }
        }
        
    }
    
}



