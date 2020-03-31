//
//  FavoritesListViewController.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/31.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
  let cellId = "cellId"
  
  let addToFavorite = "reload"
  
  var favoriteData: [Favorites] = [] {
    
    didSet {
      
      DispatchQueue.main.async {
        
        self.collectioveView.reloadData()
      }
    }
  }
  
  let collectioveView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      let screen = UIScreen.main.bounds
      let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setUpCollection()
      fetchData()
      NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name:  Notification.Name(addToFavorite), object: nil)
      // Do any additional setup after loading the view.
  }

  @objc func fetchData() {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    favoriteData = delegate.fetchData()
    
  }
  
  func setUpCollection() {
    
    view.addSubview(collectioveView)
    collectioveView.delegate = self
    collectioveView.dataSource = self
    collectioveView.register(CustomeCell.self, forCellWithReuseIdentifier: cellId)
  }

}

extension FavoritesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return favoriteData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
     guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CustomeCell else  { return UICollectionViewCell() }
    
    let favoriteItem = favoriteData[indexPath.item]
    
    guard let name = favoriteItem.name,
          let imageString = favoriteItem.imageString else { return UICollectionViewCell() }
    
    cell.setUpcellContent(label: name, Image: imageString, indexRow: indexPath.item)
    
    return cell
  }
  
}

extension FavoritesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let screenSize = UIScreen.main.bounds
      
      return CGSize(width: (screenSize.width - 30) / 2, height: screenSize.height  / 3 )
    }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    return 10
  }
}
