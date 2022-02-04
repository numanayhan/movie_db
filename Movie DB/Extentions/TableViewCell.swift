//
//  TableView.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit


extension UITableViewCell {
    
    // MARK: - Static Properties

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

