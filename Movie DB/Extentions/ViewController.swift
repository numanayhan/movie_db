//
//  ViewController.swift
//  Movie DB
//
//  Created by MBP  on 3.02.2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    func setStatusBar(theme:String){
         
        if theme == "dark"{
            UIApplication.shared.statusBarStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
            
        }else if theme == "light" {
            UIApplication.shared.statusBarStyle = .default
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}
