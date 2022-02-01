//
//  Movie.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation

struct Movie :Decodable, Encodable{
//   let dates: Dates?
   let page: Int?
   let results: [DataResult]?
   
}
 
struct Dates :Decodable, Encodable{
   let maximum: String?
   let minimum: String?
}
 
struct DataResult :Decodable, Encodable{
   let backdrop_path: String?
   let id: Int?
   let overview: String?
   let releaseDate: String?
   let title: String?
   let voteAverage: Double?
   let voteCount: Int?
}
  
