//
//  Navigation.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit

public class DefaultNavigation: UINavigationController {
    var isDark = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    var hide = true {
        didSet {
            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.backgroundColor  = UIColor.clear
            self.navigationBar.shadowImage = UIImage()
        }
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
}
extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}

class Navigation {
    private let window : UIWindow?
    init(window: UIWindow ) {
        self.window = window
    }
    func startApp() {
        
        let root = DefaultNavigation(rootViewController: Launch())
        window!.rootViewController = root
        window!.makeKeyAndVisible()
    }
      
     
}
