//
//  View.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit

extension UIView{
    
    func anchor(top: NSLayoutYAxisAnchor? = nil , left: NSLayoutXAxisAnchor?  = nil, bottom: NSLayoutYAxisAnchor?  = nil, right: NSLayoutXAxisAnchor?  = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width  = width {
            widthAnchor.constraint(equalToConstant: width ).isActive = true
        }
        
        if let height  = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    func addConstraintFormat(format:String,views:UIView...){
        var viewsDir = [String:UIView]()
        for(index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDir[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions() , metrics: nil , views: viewsDir))
        
        
    }
    
}
