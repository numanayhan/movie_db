//
//  Config.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
public class Config {
    
    static let shared: Config = {
        return Config()
    }()
     
    let baseUrl: String = "https://api.themoviedb.org/3"
    let apiKey: String = "ec2a6b106a323e0d4679e2c1fffad8c5"
    let imdbUrl: String = "https://imdb.com/title/"
    let imageUrl: String = "https://image.tmdb.org/t/p/w500/"
    
}

enum  Endpoints: String {
    
    case top_rated = "/movie/top_rated?"
    case movied = "/movie/"
    var name: String {
        return self.rawValue
    }
        
}
