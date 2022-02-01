//
//  GenericRequest.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class GenericRequest {
    static let shared: GenericRequest = {
        return GenericRequest()
    }()
    
    typealias handler = ((Result<Data, RespError>) -> Void)
    var requestAF: Alamofire.Request?
    
    func genericRequest<T:Decodable>( request : URLRequest ,expecting:T.Type , completion: @escaping ((Result<T?,RespError>) ->  Void  ))
    {
         
        AF.request(request).response { response  in
            
            guard let statusCode = response.response?.statusCode else { return }
             
            if statusCode == 200 {
                if response.data != nil {
                    do {
                        guard let data = response.data else {
                            completion(.failure(RespError.invalidData))
                          return
                        }
                        let result = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            print("res",result)
                            completion(.success(result))
                        }
                        
                    }   catch (let err){
                        DispatchQueue.main.async {
                            completion(.failure(RespError.invalidData))
                        }
                    }
                   
                }
            }else if statusCode == 401 {
                completion(.failure(RespError.authorize))
                 
            }else if statusCode > 500{
                completion(.failure(RespError.unavailableServer))
                
            } else {
                completion(.failure(RespError.genericError))
                
            }
            
        }
        
    }
   
}
 
