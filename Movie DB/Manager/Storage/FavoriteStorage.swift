//
//  Storage.swift
//  Movie DB
//
//  Created by MBP  on 3.02.2022.
//

import Foundation
import CoreData
import UIKit

var movieList  = [MovieCore]()

class FavoriteStorage {
      
    let context = (UIApplication.shared.delegate as! AppDelegate).persistantContainer.viewContext
    static let shared: FavoriteStorage = {
         
        return FavoriteStorage()
    }()
    var  movies : Movie_DB?
    
    func getFavorites(  completion : @escaping (Movie_DB) ->Void ){
         
        do{
            let movie = try context.fetch(Movie_DB.fetchRequest())
            DispatchQueue.main.async {
//                completion(self.movie!)
            }
        } catch{
            print("err")
        }
       
    }
    
    func saveFavorite(movie:MovieCore){
        
        let newMovie = Movie_DB(context: context)
        newMovie.overview = movie.overview
        newMovie.title = movie.title
        newMovie.id = Int16(movie.id!)
        newMovie.status = movie.status!
        newMovie.backdrop_path = movie.backdrop_path
        
        
        do{
            try context.save()
            
        }catch{
            print("err")
        }
    }
    func updateFavorite(movie:MovieCore)
    {
        let newMovie = Movie_DB(context: context)
        newMovie.status = movie.status!
         
        do{
            try context.save()
            
        }catch{
            print("err")
        }
    }
    
}
 

