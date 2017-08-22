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
    var googlebtn : UIButton!
    var  twtrbtn : UIButton!
    var fblogin : UIButton!
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
        
        //GoogleSignInButton
        googlebtn = UIButton(frame: CGRect(x: 80, y: 620, width: 50, height: 50))
        googlebtn.setImage(UIImage(named: "Go.png"), for: UIControlState.normal)
        googlebtn.addTarget(self, action: #selector(btnSignInPressed), for: UIControlEvents.touchUpInside)
        googlebtn.layer.cornerRadius = 50/2
        googlebtn.layer.masksToBounds = true
        googlebtn.backgroundColor = UIColor.white
        googlebtn.layer.borderColor = UIColor.white.cgColor
        googlebtn.layer.borderWidth = 2
        //TwitterLoginButton
        twtrbtn = UIButton(frame: CGRect(x: 180, y: 620, width: 50, height: 50))
        twtrbtn.setImage(UIImage(named: "twit.png"), for: UIControlState.normal)
        twtrbtn.addTarget(self, action: #selector(twtrbtnSignInPressed), for: UIControlEvents.touchUpInside)
        twtrbtn.layer.cornerRadius = 50/2
        twtrbtn.layer.masksToBounds = true
        twtrbtn.backgroundColor = UIColor.white
        twtrbtn.layer.borderColor = UIColor.white.cgColor
        twtrbtn.layer.borderWidth = 2
        //FacebookLoginButton
        fblogin = UIButton(frame: CGRect(x: 280, y: 620, width: 50, height: 50))
        fblogin.setImage(UIImage(named: "fbbb.jpg"), for: UIControlState.normal)
        fblogin.addTarget(self, action: #selector(fbSignInPressed), for: UIControlEvents.touchUpInside)
        fblogin.layer.cornerRadius = 50/2
        fblogin.layer.masksToBounds = true
        fblogin.backgroundColor = UIColor.white
        fblogin.layer.borderColor = UIColor.white.cgColor
        fblogin.layer.borderWidth = 2
        
        view.addSubview(fblogin)
        view.addSubview(twtrbtn)
        view.addSubview(googlebtn)
        
    }
    func fbSignInPressed()
    {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil)
            {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    
    func getFBUserData()
    {
        if((FBSDKAccessToken.current()) != nil)
        {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil)
                {
                    print(result!)
                }
            })
        }
    }
    
    
    
    func twtrbtnSignInPressed()
    {
        Twitter.sharedInstance().logIn(completion:{session, error in
            if (session != nil)
            {
                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                Auth.auth().signIn(with: credential)
                { (user, error) in
                    print("signed in firebase")
                    UserDefaults.standard.setValue(nil, forKey: "twitterID")
                }
            }
        })
        
        
    }
    func btnSignInPressed()
    {
        GIDSignIn.sharedInstance().signIn()
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

