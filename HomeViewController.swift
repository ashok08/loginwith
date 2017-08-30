//
//  HomeViewController.swift
//  emailAuth
//
//  Created by Intern on 01/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutAction(sender: AnyObject)
    {
        
        
       
                try! Auth.auth().signOut()
                print("logged out")
           self.dismiss(animated: false, completion: nil)
                
    }
}
