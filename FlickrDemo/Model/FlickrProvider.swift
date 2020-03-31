//
//  FlickrProvider.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/30.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation

class FlickrProvider {
  
  static let shared = FlickrProvider()
  
  private init () {}
  
  func fetchData(text: String, limit: Int, page: Int, completion: @escaping (Result<Databack, Error>) -> Void) {
    
    ConnectManager.shared.request(ConnectRequest.getImage(text: text, limit: limit, page: page)) { result in
      
      switch result{
        
      case .success(let data):
        
        do {
          
          let photoData = try JSONDecoder().decode(Databack.self, from: data)
            
            completion(Result.success(photoData))
          
        } catch {
          
          completion(Result.failure(error))
        }
        
      case .failure(let error):
        
        completion(Result.failure(error))
      }
    }
  }
}
