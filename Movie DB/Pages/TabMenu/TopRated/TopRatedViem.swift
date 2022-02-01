//
//  TopRatedViem.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class TopRatedViem {
    var request : URLRequest!
     
    func movies(_ pageIndex:Int, completion : @escaping (Movie,RespError?) ->Void ){
        
        let url =  Config.shared.baseUrl  + Endpoints.top_rated.name + "api_key=" + Config.shared.apiKey + "&language=en-US"
        request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
         
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 
        GenericRequest.shared.genericRequest(request: request, expecting: Movie.self) { results in

            switch results {
            case .success(let data):
                completion(data!,nil)
            case .failure( let err ):
               print("er",err)
                
            }
        }
        
    }
    
}
