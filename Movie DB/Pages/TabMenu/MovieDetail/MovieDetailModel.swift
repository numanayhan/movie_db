//
//  MovieDetailModel.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation

struct MovieDetailModel :Decodable, Encodable{
    
    let backdrop_path: String?
    let original_title:String?
    let overview:String?
    let release_date:String?
    let title:String?
    let vote_average:Double?
}
 
