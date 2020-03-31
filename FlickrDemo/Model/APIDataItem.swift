//
//  SearchCondition.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/30.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation

struct APIDataItem {
  
  let name: String
  
  let limit: Int
}

struct Favorite {
  
  let name: String
  
  let imageString: String
}

struct Databack: Codable {
    let stat: String
    let photos: Photos
}

struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    var photo: [Photo]
}

struct Photo: Codable {
    let id, owner, secret, server, title: String
    let ispublic, isfriend, isfamily, farm: Int
    let urlM: String?

  enum CodingKeys: String, CodingKey {
      case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
      case urlM = "url_m"
  }
}



