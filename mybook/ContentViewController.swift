//
//  ContentViewController.swift
//  mybook
//
//  Created by Intern on 03/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class ContentViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var image1: UIButton!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
            if((FBSDKAccessToken.current()) != nil)
            {
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil)
                    {
                        let data = result as! [String : AnyObject]
                      self.name.text = data["name"] as? String
                        let FBid = data["id"] as? String
                        let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                        self.photo.image =  UIImage(data: NSData(contentsOf: url! as URL)! as Data)                    }
                })
            }

                
    }
    
    @IBAction func home(_ sender: UIButton)
    {
        
            try! Auth.auth().signOut()
            print("logged out")
            FBSDKAccessToken.setCurrent(nil)
      }
}
