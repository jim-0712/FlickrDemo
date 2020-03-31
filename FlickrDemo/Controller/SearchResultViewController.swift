//
//  SearchResultViewController.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/30.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import Kingfisher

class SearchResultViewController: UIViewController {
  
  var page = 1
  
  let cellId = "cellId"
  
  let addToFavorite = "reload"
  
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
  
  var searchCondition: APIDataItem?
  
  var photoBack: Photos? {
    
    didSet {
      
      DispatchQueue.main.async {
        self.collectioveView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    getData()
    setUpcollectionView()
      // Do any additional setup after loading the view.
  }
  
  func setUpcollectionView() {
    
    view.addSubview(collectioveView)
    collectioveView.delegate = self
    collectioveView.dataSource = self
    collectioveView.register(CustomeCell.self, forCellWithReuseIdentifier: cellId)
  }
  
  func getData() {
    
    guard let condition = searchCondition else { return }
    
    FlickrProvider.shared.fetchData(text: condition.name, limit: condition.limit, page: page) { [weak self] result in
      
      guard let strongSelf = self else {
        
        return
      }
      
      switch result {
        
      case .success(let dataBack):
        
        if strongSelf.page == 1 {
          
          strongSelf.photoBack = dataBack.photos
          
        } else {
          
          guard var photoData = strongSelf.photoBack else {
            
            return
          }
          
          photoData.photo.forEach { photo in
            photoData.photo.append(photo)
          }
           
          strongSelf.photoBack = photoData
        }

      case .failure(let error):
        
        print(error.localizedDescription)
      }
    }
  }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return photoBack?.photo.count ?? 0
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CustomeCell else  { return UICollectionViewCell() }
    
    cell.delegate = self
    
    cell.favoriteBtn.isHidden = false
    
    guard let dataBack = photoBack?.photo[indexPath.item] else {
      
      return UICollectionViewCell()
    }
    
    guard let url = dataBack.urlM else {
      
      cell.setUpcellContent(label: dataBack.title, Image: nil, indexRow: indexPath.item)
      
      return cell
    }
    
    cell.setUpcellContent(label: dataBack.title, Image: url, indexRow: indexPath.item)
  
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
    guard let dataBack = photoBack else {
      
      return
    }
    
    if indexPath.item == dataBack.photo.count - 1 {
      page += 1
      getData()
    }
  }
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let screenSize = UIScreen.main.bounds
      
      return CGSize(width: (screenSize.width - 30) / 2, height: screenSize.height  / 4.5 )
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

extension SearchResultViewController: FavoriteManager {
  
  func tapOnBtn(cell: CustomeCell, index: Int) {
    
    var isMatch = false
    
    guard let dataBack = photoBack else {
      
      return
    }
    
    StorageManager.shared.fetchData().forEach { favor in
      
      guard let name = favor.name else {
        
        return
      }
      
      if name == dataBack.photo[index].title {
        
        isMatch = true
      }
    }
    
    if !isMatch {
     
      let loveItem = Favorite(name: dataBack.photo[index].title, imageString: dataBack.photo[index].urlM ?? "")
      
      StorageManager.shared.saveContext(favorite: loveItem)
      
      NotificationCenter.default.post(name: Notification.Name(addToFavorite), object: nil)
      
    }
  }
  
}
