//
//  TopRated.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import UIKit

class TopRated: UIViewController {
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.estimatedRowHeight = 136
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.hex("#E9ECEF")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    var movies = [DataResult]()
    
    lazy var topRatedViem:TopRatedViem = {
       return TopRatedViem()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
        
        getMovies()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if navigationController != nil{
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = true
            navigationItem.setHidesBackButton(true, animated:false)
            
            title = "Top Rated"
            
            isDark = true
            UIApplication.shared.statusBarStyle = .default
            setNeedsStatusBarAppearanceUpdate()
                   
            setLayout()
            setTableView()
        }
        
    }
    func setLayout(){
        
        view.backgroundColor = .white
        
        
    }
    func setTableView(){
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        tableView.register(MovieCell.self, forCellReuseIdentifier:  MovieCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    func getMovies() {
        if Network.isConnected(){
            topRatedViem.movies(1) { resp , err  in
                if  resp.results != nil{
                    self.movies = resp.results!
                    self.tableView.reloadData()
                    
                }else{
                    Alert.showAlert(on: self, with: "Movie" , message: "Movies Not Available")
                }
                if err != nil{
                    Alert.showAlert(on: self, with: "Movie" , message: "Movies DB Bad Request")
                }
            }
        }else{
            Alert.showAlert(on: self, with: "Movie" , message: "Network Not Available")
        }
        
    }
    
}
extension TopRated : UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else {
            fatalError("Error")
        }
        cell.setConfig(self.movies[indexPath.row])
        cell.movie = self.movies[indexPath.row]
        cell.layer.backgroundColor  = UIColor.clear.cgColor
        cell.selectedBackgroundView?.backgroundColor = .clear
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if movies[indexPath.row].id != nil{
            let ctrlView = MovieDetail()
            ctrlView.movieId  = self.movies[indexPath.row].id!
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.pushViewController(ctrlView, animated: true )
            }
        }
        
    }
    
}
