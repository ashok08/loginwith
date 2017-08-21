//
//  AppDelegate.swift
//  mybook
//
//  Created by Intern on 01/08/17.
//  Copyright © 2017 Intern. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FBSDKCoreKit
import Fabric
import TwitterKit
import TwitterCore
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate
{
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        Twitter.sharedInstance().start(withConsumerKey: "E4ab0nhaHCgpOekwC42EMf4z5", consumerSecret: "Jem1ppHOyKCjtFsW8yBb0jEdqxlQvbR4PzrnLxvA688L7JZFg1")
        Fabric.with([Twitter.self])
        
        let viewCount = UserDefaults.standard.integer(forKey: "View")
        var VC = UIViewController()
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        print(viewCount)
        if viewCount == 0
        {
            
            VC = storyboard.instantiateViewController(withIdentifier: "MainView") as! ViewController
        } else if viewCount == 1
        {
            
            VC = storyboard.instantiateViewController(withIdentifier: "Next") as! NextViewController
        } else if viewCount == 2
        {
            
            VC = storyboard.instantiateViewController(withIdentifier: "twitter") as! TwitterVC
        }else if viewCount == 3
        {
            
            VC = storyboard.instantiateViewController(withIdentifier: "google") as! Googlevc
        }else if viewCount == 4
        {
            
            VC = storyboard.instantiateViewController(withIdentifier: "content") as! ContentViewController
        }else if viewCount == 5
        {
            
            VC = storyboard.instantiateViewController(withIdentifier: "exit") as! ViewController1
        }
        else if viewCount == 6
        {
            VC = storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        }
        else if viewCount == 7
        {
            VC = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        } else if viewCount == 8
        {
            VC = storyboard.instantiateViewController(withIdentifier: "reset") as! ResetPasswordViewController
        } else {
            VC = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        }
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = VC
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
        if  FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "content")
            
            
            
            UserDefaults.standard.set(url, forKey: "url")
            UserDefaults.standard.synchronize()
            return true
        }
        if GIDSignIn.sharedInstance().handle(url,sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,annotation:options[UIApplicationOpenURLOptionsKey.annotation] )
        {
            
            UserDefaults.standard.set(url, forKey: "url1")
            UserDefaults.standard.synchronize()
            
            return true
        }
        if  Twitter.sharedInstance().application(app, open: url, options: options)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "twitter")
            
            
            return true
        }
        return false
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?)
    {
        
        if let error = error{
            print(error.localizedDescription)
            return
        }
        let story = UIStoryboard(name: "Main", bundle: nil)
        self.window!.rootViewController = story.instantiateViewController(withIdentifier: "google")
        
        print("you signed in")
        guard let authentication = user.authentication else
        {
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error)  in
            print("signed in firebase")
            
        }
        
    }
    
    
    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer =
        {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "mybook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}
extension UIViewController
{
    var app : AppDelegate
        {
        get{
            return UIApplication.shared.delegate as! AppDelegate
            
        }
    }
}
