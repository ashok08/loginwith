//
//  TwitterVC.swift
//  mybook
//
//  Created by Intern on 14/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FirebaseAuth
import TwitterKit
import Fabric
import TwitterCore

class TwitterVC: UIViewController
{
    
    
    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserDefaults.standard.set(2, forKey: "View")
        let client = TWTRAPIClient.withCurrentUser()
        
        client.requestEmail { email, error in
            if (email != nil) {
                
                print(email!)
                self.userEmail.text = email
                
            }
            else
            {
                print("error: \(error?.localizedDescription)");
            }
        }
     }
    
    @IBAction func logout(_ sender: UIButton)
    {
        let firebaseAuth = Auth.auth()
        do
        {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
     }
    
}
