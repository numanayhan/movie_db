//
//  Launch.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import UIKit
import TinyConstraints
class Launch: UIViewController {
    
    lazy var logo : UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font =  UIFont(name: "Futura-Medium", size: 44)
        label.textColor  = UIColor.white
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    weak var timer: Timer?
    private var spinner: Spinner!
    private var selectedColor: UIColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        setLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if navigationController != nil{
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        setSpinner()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDark ? .lightContent : .default
    }
    func setLayout(){
        view.backgroundColor = UIColor.black
        view.addSubview(logo)
        logo.centerInSuperview()
        logo.width(190)
        logo.height(50)
        
    }
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval:2, repeats: false) {  _ in
            self.stopTimer()
            self.navigationController?.pushViewController(TopRated(), animated: true )
            
        }
    }
    func stopTimer() {
        timer?.invalidate()
    }
    deinit {
        stopTimer()
    }
    
    func setSpinner(){
        
        
        spinner = ChasingDotsSpinner(
            primaryColor: UIColor.white,
            frame: CGRect(origin: .zero,
                          size: CGSize(width: 50, height: 50)
                         )
        )
        spinner.contentInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        spinner.animationSpeed = 1
        spinner.isTranslucent = true
        view.addSubview(spinner)
        spinner.anchor(top: nil , left: view.leftAnchor, bottom: view.bottomAnchor, right: nil , paddingTop: 0, paddingLeft: (view.frame.width - spinner.frame.width )/2  - 25, paddingBottom: view.frame.height/6, paddingRight: 0, width: 100, height: 100)
        spinner.startLoading()
        
        
    }
}
