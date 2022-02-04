//
//  MovieDetail.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import UIKit
import SDWebImage
import TinyConstraints
class MovieDetail: UIViewController {
    
    //Film resmi için imageview tanımlandı.
    lazy  var image : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    // favoriler belirten icon için imageview tanımlandı.
    lazy var favIcon : UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 20))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "unfav")
        return iv
    }()
    // favoriler değiştirmek için button tanımlandı.
    lazy var  fav: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        button.setImage(favIcon.image, for: .normal)
        button.addTarget(self , action: #selector(setFav), for: .touchUpInside)
        return button
    }()
    // Film detayları için textview tanımlandı.
    
    lazy var overview:UITextView = {
        let tv  = UITextView()
        tv.font = UIFont(name: "Futura-Regular", size: 18)
        tv.text = "-"
        tv.textColor = UIColor.hex("#2B2D42")
        tv.isEditable = false
        tv.sizeToFit()
        return tv
    }()
    //ModelView sorguları için singleton tanımlandı.
    lazy var movieDetailMV: MovieDetailViem = {
        return MovieDetailViem()
    }()
    // Filmlerin CoreData ile kayıt alınan modeli değişkene alındı.
    private var movies: Movie_DB?
    // Film detaylarının değişkeni belirlendi.
    var movie:MoviesDetail?
    // Film id alınarak sorgu alınması yapılıyor.
    var movieId:Int = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setLayout()
        getMovieDetail(movieId)
        getFavorites()
        
    }
    func getMovieDetail(_ sender:Int){
        // Film detayları ve internet kontrolü yapıldı.
        if Network.isConnected(){
            
            movieDetailMV.movieDetail(sender){resp in
                if resp.title != nil{
                    if resp.backdrop_path != nil{
                        let posterPath = Config.shared.imageUrl +  resp.backdrop_path!
                        let url  = URL(string: (posterPath))
                        self.image.sd_setImage(with: url, placeholderImage: UIImage(), options: SDWebImageOptions.scaleDownLargeImages, context: nil)
                    }
                    self.overview.text = resp.overview
                    self.navigationItem.title  = resp.title
                    self.movie = resp
                    
                }
            }
        }else{
            //Uyarılar için custom alert verildi
            Alert.showAlert(on: self, with: "Movie" , message: "Network Not Available")
        }
        
    }
    
    @objc func setFav(){
        // Core Data içinde önceden aynı film kaydedilmişse favori olarak getiriliyor.
        // Eğer favori film değilse de favorilere ekliyor.
        FavoriteStorage.shared.getFavorites { movie  in
             
            if self.movieId == movie.id &&  movie.status == true {
                FavoriteStorage.shared.updateFavorite(movie: MovieCore(id: Int16(self.movieId), backdrop_path:Config.shared.imageUrl + movie.backdrop_path! , title: movie.title, overview: movie.overview , status: false ))
            }else if self.movieId != movie.id{
                FavoriteStorage.shared.saveFavorite(movie: MovieCore(id: Int16(self.movieId), backdrop_path:Config.shared.imageUrl + movie.backdrop_path! , title: movie.title, overview: movie.overview , status: true  ))
            }
        }
         
        getFavorites()
         
        
    }
    
    func getFavorites(){
        // Favoriler iconlaro için status  bakılarak logo değiştirilir.
        FavoriteStorage.shared.getFavorites { movie  in
            
            if movie.status {
                self.favIcon.image = UIImage(named:"fav")
            }else{
                self.favIcon.image = UIImage(named:"unfav")
                
            }
        }
        self.fav.setImage(self.favIcon.image, for: .normal)
    }
    
}
extension MovieDetail {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
        
    }
    // NavigationBar design edilir.
    func setNavigationBar(){
        if navigationController != nil {
          
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationItem.setHidesBackButton(false, animated:false)
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .always
            navigationController?.navigationBar.backItem?.title = " "
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:" ", style:.plain, target:nil, action:nil)
            navigationController?.navigationBar.tintColor = .black
            navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: fav)
            
            isDark = true
            setStatusBar(theme: "dark")
            
            UIApplication.shared.statusBarStyle = .default
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}
extension MovieDetail{
    func setLayout(){
        
        view.backgroundColor = .white
        
        view.addSubview(image)
        image.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 256)
        
        
        view.addSubview(overview)
        overview.anchor(top: image.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft:20, paddingBottom: 0, paddingRight: 20, width: view.frame.width, height: view.frame.height)
         
        
    }
}
