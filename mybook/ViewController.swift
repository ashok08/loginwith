//
//  ViewController.swift
//  mybook
//
//  Created by Intern on 01/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
class ViewController: UIViewController,FBSDKLoginButtonDelegate
{

    @IBOutlet weak var facebooklogin: FBSDKLoginButton!
    
        override func viewDidLoad(){
            super.viewDidLoad()
            facebooklogin.delegate = self
        }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {

       if let error = error
            {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else
            {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

            Auth.auth().signIn(with: credential, completion:
                { (user, error) in
                if let error = error
                {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
               
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "content") {
               self.present(viewController, animated: true, completion: nil)
                }
                
                    
            })
            
        }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! Auth.auth().signOut()
        print("logout")
    }
    }

