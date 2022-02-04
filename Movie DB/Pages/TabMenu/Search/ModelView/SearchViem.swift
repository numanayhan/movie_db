//
//  SearchViem.swift
//  Movie DB
//
//  Created by MBP  on 4.02.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class SearchViem {
    var request : URLRequest!
    // URL Request edilmesi sonucu comletion alınır.
    func search(_ text:String,completion : @escaping (Movies) ->Void ){
        // base url ve parametreler eklenir.
        let baseUrl = Config.shared.baseUrl + Endpoints.search.name + "?api_key=" + Config.shared.apiKey + "&query=" + text
         
        request = URLRequest(url:URL(string:  baseUrl)!,timeoutInterval: .infinity)
        request.httpMethod = "GET"
        
        //Generic sorgu ile singleton işlemleri tek bir sorgu ile yapılor.
        // Movies.self ile de resp geri dönüş beklenti tipi belirlenir.
        
        GenericRequest.shared.genericRequest(request: request, expecting: Movies.self) { results in
            switch results {
            case .success(let data):
                completion(data!)
            case .failure( let err ):
               print("er",err)
            }
        }
        
    }
}
