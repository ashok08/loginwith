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


class ViewController1: UIViewController
{
    @IBOutlet weak var pic: UIImageView!
    var Value1: UIImage? = UIImage(named: " ")
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserDefaults.standard.set(5, forKey: "View")
        pic.image = Value1
    }
}
