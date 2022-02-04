//
//  Search.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import UIKit

class Search: UIViewController {
    // Arama işlemi için UISearchController özellikleri tanımlandı.
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search"
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.autocapitalizationType = .allCharacters
        sc.hidesNavigationBarDuringPresentation = true
        sc.searchBar.searchBarStyle = .minimal
        sc.definesPresentationContext = false
        sc.searchBar.keyboardType = .alphabet
        sc.searchBar.keyboardAppearance = .default
        sc.searchBar.returnKeyType = .done
        return sc
    }()
    //TableView tanımlandı
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.estimatedRowHeight = 136
        tv.rowHeight = UITableView.automaticDimension
        tv.allowsMultipleSelection = false
        tv.separatorStyle = .singleLine
        tv.separatorColor = UIColor.hex("#E9ECEF")
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        return tv
    }()
    
    var movies = [MovieResult]()
    var searchMovies  = [MovieResult]()
    //  Search : UIViewController class'ına özel MVVM tanımlandı.
    
    lazy var searchViem:SearchViem = {
       return SearchViem()
    }()
    
    //  SearchBar boş olması alındı.
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // Arama yapılması değişken ile tanımlandı.
    var isSearching:Bool{
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var selectedIndex = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setLayout()
        setTableView()
        setNavigationBar()
        
    }
    func setLayout(){
        view.backgroundColor = .white
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
    func setTableView(){
        
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor , right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        
    }

}

extension Search : UISearchResultsUpdating, UISearchControllerDelegate{
    //github users içinde listemele yapılır
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2{
            searchMovies(text.lowercased())
        }else {
            movies.removeAll()
        }
        tableView.reloadData()
    }
}
extension Search {
    func searchMovies(_ text:String){
        searchViem.search(text) { movie  in
            self.movies =  movie.results
            self.tableView.reloadData()
        }
        
    }
    
}
extension Search : UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell {
            
            cell.layer.backgroundColor  = UIColor.clear.cgColor
            cell.selectedBackgroundView?.backgroundColor = .clear
             
            if isSearching && searchController.searchBar.text!.count > 2{
                 
                cell.setConfig(self.movies[indexPath.row])
                
            }
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if Int(self.movies[indexPath.row].id) != 0{
            let ctrlView = MovieDetail()
            ctrlView.movieId  = Int(self.movies[indexPath.row].id)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(ctrlView, animated: true )
            }
        }
    }
    
}
extension Search{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.setNavigationBar()
        }
        
    }
    @objc func cancelSearch(){
        self.view.endEditing(true)
        self.navigationItem.searchController?.isActive = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        self.navigationItem.searchController?.isActive = false
    }
    
}
extension Search{
    
    func setNavigationBar(){
        if navigationController != nil {
            isDark = true
            setStatusBar(theme: "dark")
            navigationItem.title = "Search Movie"
            
            navigationController?.setNavigationBarHidden(false, animated: true)
            navigationController?.navigationBar.isHidden = false
            navigationItem.setHidesBackButton(true, animated:false)
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.tintColor = UIColor.black
            searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
            self.navigationItem.searchController  = searchController
            UIApplication.shared.statusBarStyle = .default
            setNeedsStatusBarAppearanceUpdate()
            
        }
    }
    
}
