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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserDefaults.standard.set(3, forKey: "View")
    }
    
    @IBAction func logout(_ sender: UIButton)
    {
         GIDSignIn.sharedInstance().signOut()
        try! Auth.auth().signOut()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
