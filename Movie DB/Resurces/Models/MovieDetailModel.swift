//
//  MovieDetailModel.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation

struct MoviesDetail :Decodable, Encodable{

    let backdrop_path: String?
    let overview:String?
    let title:String?
    let id:Int?
    
}

struct MovieCore {
    var id: Int16?
    var backdrop_path: String?
    var title: String?
    var overview: String?
    var status:Bool?
}
