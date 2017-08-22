//
//  Googlevc.swift
//  mybook
//
//  Created by Intern on 14/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class Googlevc: UIViewController
{
    @IBOutlet weak var name: UILabel!
    var name1 : String!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserDefaults.standard.set(3, forKey: "View")
        let user = Auth.auth().currentUser;
        
        
        if (user != nil) {
            name1 = user?.displayName;
            name.text = name1
        }

        
        
    }
    
    @IBAction func logout(_ sender: UIButton)
    {
         GIDSignIn.sharedInstance().signOut()
        try! Auth.auth().signOut()
        print("logged out")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
