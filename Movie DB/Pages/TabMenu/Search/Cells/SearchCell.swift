//
//  SearchCell.swift
//  Movie DB
//
//  Created by MBP  on 4.02.2022.
//

import UIKit
import SDWebImage
import TinyConstraints
class SearchCell:  UITableViewCell {
    
    lazy var image : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        return iv
    }()
    lazy var titleLabel: UILabel  = {
        let lbl = UILabel()
        lbl.textColor = UIColor.hex("#2B2D42")
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    lazy var detailLabel: UILabel  = {
        let lbl = UILabel()
        lbl.textColor = UIColor.hex("#8D99AE")
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textAlignment = .left
         
        return lbl
    }()
    lazy var rightArrow:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "right")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    var movie  : MovieResult! = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.clear
        } else if isHighlighted{
            contentView.backgroundColor = UIColor.clear
        }else{
            contentView.backgroundColor = .clear
        }
    }
    func setLayout(){
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectedBackgroundView?.backgroundColor  = .clear
        
        contentView.addSubview(image)
        image.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil , paddingTop: 16, paddingLeft:16, paddingBottom: 16, paddingRight: 0, width: 108, height: 108)
         
        contentView.addSubview(rightArrow)
        rightArrow.anchor(top: contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor , paddingTop: 42, paddingLeft:0, paddingBottom: 0, paddingRight:16, width: 16, height: 16)
        
        
        
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor , left: image.rightAnchor, bottom: nil, right: rightArrow.leftAnchor, paddingTop: 8, paddingLeft:16, paddingBottom: 8, paddingRight: 16, width: contentView.frame.width, height: 40)
        
        
        contentView.addSubview(detailLabel)
        detailLabel.anchor(top: titleLabel.bottomAnchor , left: image.rightAnchor, bottom: contentView.bottomAnchor, right: rightArrow.leftAnchor, paddingTop: 0, paddingLeft:16, paddingBottom:16, paddingRight: 16, width: contentView.frame.width, height: contentView.frame.height)
        
        
    }
    func setConfig(_ sender:MovieResult){
        movie = sender 
        titleLabel.text = sender.title
        detailLabel.text = sender.overview
        if sender.backdrop_path != nil{
            let posterPath = Config.shared.imageUrl +  sender.backdrop_path!
            let url  = URL(string: (posterPath))
            image.sd_setImage(with: url, placeholderImage: UIImage(), options: SDWebImageOptions.scaleDownLargeImages, context: nil)

        }
        
    }
    
}
 
