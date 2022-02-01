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
    
    let  imdb:UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 49, height: 24))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "imdb")
        return iv
    }()
    lazy var  vote:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.hex("#2B2D42")
        label.font = UIFont(name: "SFProText-Medium", size: 13)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    lazy var  release:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Medium", size: 13)
        label.text = "00.00.0000"
        label.textColor = UIColor.hex("#2B2D42")
        return label
    }()
    lazy var starView :UIView = {
        let view = UIView()
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "star")
        
        view.addSubview(iv)
        iv.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil , right: nil , paddingTop: 4 , paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
        
        
        view.addSubview(vote)
        vote.anchor(top: view.topAnchor, left: iv.rightAnchor, bottom: nil , right: nil , paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 30, height: 16)
        
        let point = UIView()
        point.backgroundColor = UIColor.hex("#E6B91E")
         
        view.addSubview(point)
        point.anchor(top: view.topAnchor, left: vote.rightAnchor, bottom: nil , right: nil, paddingTop: 10, paddingLeft: 2, paddingBottom: 0, paddingRight: 0, width: 4, height: 4)
        point.layer.cornerRadius = 4
        
        
        view.addSubview(release)
        release.anchor(top: view.topAnchor, left: point.rightAnchor, bottom: nil , right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: release.frame.width, height: view.frame.height)
        
        
        return view
    }()
    lazy var status:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 36))
         
        view.addSubview(imdb)
        imdb.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil , right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 49, height: 24)
        
        view.addSubview(starView)
        starView.anchor(top: view.topAnchor, left: imdb.rightAnchor, bottom: nil , right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 100, height: 24)
         
        return view
    }()
    lazy var overview:UITextView = {
        let tv  = UITextView()
        tv.font = UIFont(name: "Futura-Regular", size: 15)
        tv.text = "-"
        tv.textColor = UIColor.hex("#2B2D42")
        tv.isEditable = false
        
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
        if movieId != 0{
            
            getMovieDetail(movieId)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController != nil{
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationController?.isNavigationBarHidden = false
            navigationItem.setHidesBackButton(false , animated:false)
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.topItem?.title = " "
            
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if navigationController != nil{
            navigationController?.navigationBar.isHidden = true
        }
    }
    func setLayout(){
        
        view.backgroundColor = .white
        image.backgroundColor = .clear
        view.addSubview(image)
        image.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft:0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 256)
        
        view.addSubview(status)
        status.anchor(top: image.bottomAnchor, left: view.leftAnchor, bottom: nil , right: view.rightAnchor, paddingTop:  16, paddingLeft: 20  , paddingBottom: 20, paddingRight: 20, width: view.frame.width, height: 35)
        
        view.addSubview(overview)
        overview.anchor(top: status.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft:20, paddingBottom: 0, paddingRight: 20, width: view.frame.width, height: view.frame.height)
        
        
        
    }
    func getMovieDetail(_ sender:Int){
        
        if Network.isConnected(){
         
            movieDetailMV.movieDetail(sender){resp in
                if resp.title != nil{
                    self.title = resp.title
                    let posterPath = Config.shared.imageUrl +  resp.backdrop_path!
                    let url  = URL(string: (posterPath))
                     
                    self.image.sd_setImage(with: url, placeholderImage: UIImage(), options: SDWebImageOptions.scaleDownLargeImages, context: nil)
                    
                    self.vote.text = String(resp.vote_average!) + "/10"
                    self.release.text = String(resp.release_date!)
                    self.overview.text = resp.overview
                    
                }else{
                    Alert.showAlert(on: self, with: "Movie" , message: "Movies Not Available")
                }
               
            }
        }else{
            Alert.showAlert(on: self, with: "Movie" , message: "Network Not Available")
        }
    }

}
