//
//  AppDelegate.swift
//  Movie DB
//
//  Created by Numan Ayhan on 29.01.2022.
//

import UIKit
import CoreData

var rooter : Navigation?

var isDark = false {
    didSet {
        UIApplication.shared.statusBarStyle = .lightContent
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 0.0)
        setNavigation()
        return true
    }
    func setNavigation(){
        
        isDark = false 
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let statusBarView = UIView()
        statusBarView.backgroundColor = UIColor.hex("#10151C")
        window?.addSubview(statusBarView)
        window?.addConstraintFormat(format: "H:|[v0]", views: statusBarView)
        window?.addConstraintFormat(format: "V:|[v0(20)]", views: statusBarView)
        
        rooter = Navigation(window: window!)
        rooter?.startApp()
        
    }
}

