//
//  TopRatedViem.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
class TopRatedViem {
    var request : URLRequest!
     // URL Request edilmesi sonucu comletion alınır.
    func movies(completion : @escaping (Movies,HelpError?) ->Void ){
        // base url ve parametreler eklenir.
        let url =  Config.shared.baseUrl  + Endpoints.top_rated.name + "api_key=" + Config.shared.apiKey + "&language=en-US"
        request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //Generic sorgu ile singleton işlemleri tek bir sorgu ile yapılor.
        // Movie.self ile de resp geri dönüş beklenti tipi belirlenir.
        
        GenericRequest.shared.genericRequest(request: request, expecting: Movies.self) { results in
            
            switch results {
            case .success(let data):
                completion(data!,nil)
            case .failure( let err ):
               print("er",err)
                
            }
        }
        
    }
    
}
