//
//  ContentViewController.swift
//  mybook
//
//  Created by Intern on 03/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var image: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         UserDefaults.standard.set(4, forKey: "View")
        
    }
    
    @IBAction func home(_ sender: UIButton)
    {
 let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView")
        present(vc, animated: true, completion: nil)
    }

   
}
