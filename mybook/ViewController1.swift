//
//  ViewController1.swift
//  mybook
//
//  Created by Intern on 02/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth


class ViewController1: UIViewController {

    @IBOutlet weak var pic: UIImageView!
  
  var Value1: UIImage? = UIImage(named: " ")
        override func viewDidLoad() {
            super.viewDidLoad()
             pic.image = Value1
             }

    @IBAction func logout(_ sender: UIButton) {
        
    
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "content")
                     present(vc, animated: true, completion: nil)
       
        
}
}
