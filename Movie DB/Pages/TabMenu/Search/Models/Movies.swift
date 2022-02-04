//
//  Movies.swift
//  Movie DB
//
//  Created by MBP  on 4.02.2022.
//

import Foundation

struct Movies:Decodable, Encodable{
    
    let page: Int
    let results: [MovieResult]
    
}

// MARK: - Result
struct MovieResult :Decodable, Encodable{
    
    let backdrop_path: String?
    let id: Int
    let original_language, original_title, overview: String?
    let poster_path, release_date, title: String?
    
}
