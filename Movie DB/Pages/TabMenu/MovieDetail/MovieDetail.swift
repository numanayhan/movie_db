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
    lazy  var image : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var  fav: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        button.setImage(UIImage(named: "unfav"), for: .normal)
        button.addTarget(self , action: #selector(setFav), for: .touchUpInside)
        return button
    }()
    
    lazy var overview:UITextView = {
        let tv  = UITextView()
        tv.font = UIFont(name: "Futura-Regular", size: 18)
        tv.text = "-"
        tv.textColor = UIColor.hex("#2B2D42")
        tv.isEditable = false
        tv.sizeToFit()
        
        return tv
    }()
    lazy var movieDetailMV: MovieDetailViem = {
        return MovieDetailViem()
    }()
    var movie:MovieDetailModel!
    var movieId:Int = 0
    var statusStack  = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        getMovieDetail(movieId)
        
    }
    
    func setLayout(){
        
        view.backgroundColor = .white
        
        view.addSubview(image)
        image.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 256)
        
        
        view.addSubview(overview)
        overview.anchor(top: image.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft:20, paddingBottom: 0, paddingRight: 20, width: view.frame.width, height: view.frame.height)
        
        
        
    }
    func getMovieDetail(_ sender:Int){
        
        if Network.isConnected(){
            
            movieDetailMV.movieDetail(sender){resp in
                if resp.title != nil{
                    self.title = resp.title
                    let posterPath = Config.shared.imageUrl +  resp.backdrop_path!
                    let url  = URL(string: (posterPath))
                    
                    self.image.sd_setImage(with: url, placeholderImage: UIImage(), options: SDWebImageOptions.scaleDownLargeImages, context: nil)
                    
                    
                    self.overview.text = resp.overview
                    
                }else{
                    Alert.showAlert(on: self, with: "Movie" , message: "Movies Not Available")
                }
                
            }
        }else{
            Alert.showAlert(on: self, with: "Movie" , message: "Network Not Available")
        }
    }
    
    @objc func setFav(){
        
    }
}
extension MovieDetail {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController != nil{
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationController?.isNavigationBarHidden = false
            navigationItem.setHidesBackButton(false , animated:false)
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.topItem?.title = " "
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: fav)
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController != nil{
            navigationController?.navigationBar.isHidden = true
        }
    }
}
