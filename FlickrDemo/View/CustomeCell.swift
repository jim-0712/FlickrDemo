//
//  CustomeCell.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/31.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteManager: AnyObject {
  
  func tapOnBtn(cell: CustomeCell, index: Int)
  
}

class CustomeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
  
  weak var delegate: FavoriteManager?
  
  var index = 0
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.gray
        return image
    }()
    
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.text = "New Person"
        return label
    }()
  
    lazy var favoriteBtn: UIButton = {
       let btn = UIButton()
       btn.translatesAutoresizingMaskIntoConstraints = false
       btn.backgroundColor = .white
       btn.layer.borderWidth = 1.0
       btn.layer.borderColor = UIColor.lightGray.cgColor
       btn.setTitleColor(.black, for: .normal)
       btn.addTarget(self, action: #selector(tapBtn(_:)), for: .touchUpInside)
       btn.setTitle("收藏", for: .normal)
       return btn
  }()
  
  @objc func tapBtn(_ sender: UIButton) {

    self.delegate?.tapOnBtn(cell: self, index: index)
    
  }
  
  func setUpcellContent(label: String, Image: String?, indexRow: Int) {
      
      index = indexRow
      self.backgroundColor = .white
      textLabel.text = label
      guard let image = UIImage(named: "placeHolder") else {
        
        return
      }
      
      imageView.loadImage(Image, placeHolder: image)
  }
    
    func setupView() {
      addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        imageView.topAnchor.constraint(equalTo: self.topAnchor),
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)
      ])
      
      addSubview(textLabel)
      NSLayoutConstraint.activate([
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor)
      ])
      
      addSubview(favoriteBtn)
      NSLayoutConstraint.activate([
        favoriteBtn.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        favoriteBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        favoriteBtn.widthAnchor.constraint(equalToConstant: 100),
        favoriteBtn.heightAnchor.constraint(equalToConstant: 30)
      ])

    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
