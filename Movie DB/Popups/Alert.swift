//
//  Alert.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit


struct Alert {
 
  static func showAlert(on vc:UIViewController, with title:String, message:String) {
     
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
  
    alert.addAction(UIAlertAction(title: "Done" , style: .default, handler: nil))
                        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
     }
  }
}
