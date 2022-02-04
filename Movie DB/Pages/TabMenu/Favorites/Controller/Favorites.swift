//
//  Favorites.swift
//  Movie DB
//
//  Created by MBP  on 4.02.2022.
//

import UIKit

class Favorites: UIViewController {
    // Filmler listelenmesi TableView oluşturulur.
    // Yükseklik 136 ve renkleri seçilerek tema giydirilir.
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear 
        tableView.estimatedRowHeight = 136
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.hex("#E9ECEF")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    // filmleri model tipinde değişkene atanır.
    var movies = [DataResult]()
    // Singleton tipinde ModelView değişten ile alınır.
    override func viewDidLoad() {
        super.viewDidLoad()
 
        getFavorites()
        setLayout()
        setNavigationBar()
        //setTableView()
        
    }
    func getFavorites(){
        
        FavoriteStorage.shared.getFavorites { movie  in
            print("mm:",movie.id)
            
        }
        
    }
    //View temaya göre renkleri verilir.
    func setLayout(){
        
        view.backgroundColor = .white
            
    }
    
    // Multi tema eklenmesi durumunda status bar renkleri değiştirilir.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
    // TableView eklenmesi için view subview olarak alınır.
    // anchor ile yerleşimi yapılr.
    // Cell ile her item gösterimi için  register edilir.
    func setTableView(){
        
        tableView.register(FavCell.self, forCellReuseIdentifier:  "FavCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        
        tableView.reloadData()
        
    }
}
extension Favorites : UITableViewDelegate ,UITableViewDataSource{
    // liste sayısı ile tableview section sayısı verilir.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movies.count > 0{
            return self.movies.count
        }
        return 0
    }
    // her bir cell objesi config ile atanır.
    //birdern fazla cell için if kullanılmıştır.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavCell {
            cell.setConfig(self.movies[indexPath.row])
            cell.movie = self.movies[indexPath.row]
            cell.layer.backgroundColor  = UIColor.clear.cgColor
            cell.selectedBackgroundView?.backgroundColor = .clear
             
            return cell
        }
        
        return UITableViewCell()
    }
    //Cell yüksekliği verilir.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    //Seçilen film detay ekranına gönderilir.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("id",Int(self.movies[indexPath.row].id!))
//        if movies[indexPath.row].id != nil{
//            let ctrlView = MovieDetail()
//            ctrlView.movieId  = Int(self.movies[indexPath.row].id!)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.navigationController?.pushViewController(ctrlView, animated: true )
//            }
//        }
        
    }
    
}
extension Favorites{
    // NavigationBar aktif edilir.
    func setNavigationBar(){
        if navigationController != nil {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(true, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Favorites"
            isDark = true
            setStatusBar(theme: "dark")
            
        }
    }
    
}
