//
//  AppDelegate.swift
//  GitJobs
//
//  Created by Rustam on 01.04.2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let assembly: AssemblyP = Assembly()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config
        
        window = UIWindow(frame: UIScreen.main.bounds)
       
        window?.rootViewController = assembly.resolve() as JobsViewController
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

