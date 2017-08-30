//
//  LoginViewController.swift
//  emailAuth
//
//  Created by Intern on 01/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class LoginViewController: UIViewController
{
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    
    
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        UserDefaults.standard.set(7, forKey: "View")
    }
    
    
    @IBAction func loginAction(_ sender: AnyObject)
    {
        if self.emailTextField.text == "" || self.passwordTextField.text == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!)
            { (user, error) in
                if error == nil
                {
                print("You have successfully logged in")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.present(vc!, animated: true, completion: nil)
                }
                else
                {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

