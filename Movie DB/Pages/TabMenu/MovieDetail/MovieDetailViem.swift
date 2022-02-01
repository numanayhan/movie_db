//
//  MovieDetailViem.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class MovieDetailViem {
    var request : URLRequest!
     
    func movieDetail(_ movieId:Int, completion : @escaping (MovieDetailModel) ->Void ){
        
        let url =  Config.shared.baseUrl  + Endpoints.movied.name + String(movieId) + "?api_key=" + Config.shared.apiKey 
        request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 
        GenericRequest.shared.genericRequest(request: request, expecting: MovieDetailModel.self) { results in
            switch results {
            case .success(let data):
                completion(data!)
            case .failure( let err ):
               print("er",err)
            }
        }
        
    }
    
}
