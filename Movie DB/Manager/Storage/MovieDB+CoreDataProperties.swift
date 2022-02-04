//
//  MovieDB+CoreDataProperties.swift
//  
//
//  Created by MBP  on 3.02.2022.
//
//

import Foundation
import CoreData


extension Movie_DB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie_DB> {
        return NSFetchRequest<Movie_DB>(entityName: "Movie_DB")
    }
    @NSManaged public var backdrop_path: String?
    @NSManaged public var id: Int16
    @NSManaged public var overview: String?
    @NSManaged public var title: String?
    @NSManaged public var status: Bool

}
