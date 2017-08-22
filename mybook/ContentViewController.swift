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

    @IBOutlet weak var image: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
    
    @IBAction func home(_ sender: UIButton)
    {
        
            try! Auth.auth().signOut()
            print("logged out")
            FBSDKAccessToken.setCurrent(nil)
      }
}
