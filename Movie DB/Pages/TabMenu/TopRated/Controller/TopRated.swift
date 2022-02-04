//
//  TopRated.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import UIKit

class TopRated: UIViewController {
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
    var movies = [MovieResult]()
    // Singleton tipinde ModelView değişten ile alınır.
    lazy var topRatedViem:TopRatedViem = {
       return TopRatedViem()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
       
        //Top Rate filmleri getirilir.
        getMovies()
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLayout()
        setTableView()
        setNavigationBar()
         
        
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
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        tableView.register(MovieCell.self, forCellReuseIdentifier:  MovieCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    func getMovies() {
        // internet kontrolü yapılır.
        // tatalar ile alert gösterilir.
        if Network.isConnected(){
            //ModelView çağrılır.
            topRatedViem.movies() { resp , err  in
                 
                if  resp.results.count  > 0 {
                    // Response değişkene atanır.
                    self.movies = resp.results
                    // Liste yenilenir.
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
    // liste sayısı ile tableview section sayısı verilir.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    // her bir cell objesi config ile atanır.
    //birdern fazla cell için if kullanılmıştır.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell {
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
        
        if movies[indexPath.row].backdrop_path != ""{
            let ctrlView = MovieDetail()
            ctrlView.movieId  = Int(self.movies[indexPath.row].id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(ctrlView, animated: true )
            }
        }
        
    }
    
}
extension TopRated{
    // NavigationBar aktif edilir.
    func setNavigationBar(){
        if navigationController != nil {
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(true, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Top Rated"
            isDark = true
            setStatusBar(theme: "dark")
            
        }
    }
    
}
