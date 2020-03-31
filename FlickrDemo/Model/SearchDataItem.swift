//
//  SearchDataItem.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/31.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation


enum Search: String {
  
  case searchCount = "每頁呈現數量"
  
  case searchContent = "欲搜尋內容"
  
  case search = "搜尋"
}

protocol Storyboard {
  
  var storyBoardName: String { get }
  
  var storyBoardIdentifier: String { get }
  
}

enum SearchResult: Storyboard {

  case searchResultVC
  
  var storyBoardName: String {
    
    switch self {
    case .searchResultVC:
      
      return "SearchResult"
      
    }
  }
    
    var storyBoardIdentifier: String {
      
      switch self {
      case .searchResultVC:
        
        return "SearchResultViewController"
        
      }
    }
}
