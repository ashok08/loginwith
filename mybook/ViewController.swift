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
import TwitterKit
import TwitterCore
import Fabric
import GoogleSignIn
class ViewController: UIViewController,FBSDKLoginButtonDelegate, GIDSignInUIDelegate
{
    @IBOutlet weak var twitterlogin: TWTRLogInButton!
    @IBOutlet weak var facebooklogin: FBSDKLoginButton!
    @IBOutlet weak var googlelogin: GIDSignInButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: "View")
        
        facebooklogin.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        googlelogin.style = .wide
        
        
        twitterlogin.logInCompletion = {session, error in
            if (session != nil)
            {
                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                Auth.auth().signIn(with: credential)
                { (user, error) in
                print("signed in firebase")
                UserDefaults.standard.setValue(nil, forKey: "twitterID")
                }
            }
         }
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!)
    {
        if Auth.auth().currentUser != nil
        {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "google")
            self.present(viewController!, animated: true, completion: nil)
        }
        else
        {
            UserDefaults.standard.url(forKey: "url1")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!)
    {
        
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
        })
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool
    {
        return true
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        try! Auth.auth().signOut()
        print("logout")
    }
}

