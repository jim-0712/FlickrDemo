//
//  APIManager.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/30.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation

enum JMHTTPClientError: Error {

    case decodeDataFail

    case clientError(Data)

    case serverError

    case unexpectedError
}

protocol  JMRequest {
  
  var headers: [String: String]? { get }
  
  var body: Data? { get }
  
  var method: String { get }
  
  var urlString: String { get }
  
}

enum HeaderMethod: String {
  
  case get = "GET"
  
}

extension JMRequest {
  
  func makeRequest() -> URLRequest {
    
    let url = URL(string: urlString)!
    
    var request = URLRequest(url: url)
    
    request.allHTTPHeaderFields = headers
    
    request.httpBody = body
    
    request.httpMethod = method
    
    return request
  }
}

enum ConnectRequest: JMRequest {
  
  case getImage(text: String, limit: Int, page: Int)
  
  var headers: [String : String]? {
    
    switch self {
      
    case .getImage: return [:]
      
    }
  }
  
  var body: Data? {
    
    switch self {
      
    case .getImage:
      
      return nil
    }
  }
  
  var method: String {
    
    switch self {
      
    case .getImage: return HeaderMethod.get.rawValue
      
    }
  }
  
  var urlString: String{
    
    switch self {
      
    case .getImage(let text, let limit, let page):
      return "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=2076e4ab5cfe4ad4345f890205010ff9&tags=\(text)&extras=url_m&per_page=\(limit)&page=\(page)&format=json&nojsoncallback=1"
      
    }
  }
}

enum Apierror: Error {
  
  case APIError
}

class ConnectManager {
  
  static let shared = ConnectManager()
  
  let decoder = JSONDecoder()
  
  let session = URLSession(configuration: URLSessionConfiguration.default)
  
  func request(_ request: JMRequest, completion: @escaping (Result<Data, Error>) -> Void) {
      
      URLSession.shared.dataTask(with: request.makeRequest(), completionHandler: { (data, response, error) in

          guard error == nil else {

              return completion(Result.failure(error!))
          }
          
          let httpResponse = response as! HTTPURLResponse
         
          let statusCode = httpResponse.statusCode

          switch statusCode {

          case 200..<300:

              completion(Result.success(data!))

          case 400..<500:

              completion(Result.failure(JMHTTPClientError.clientError(data!)))

          case 500..<600:

              completion(Result.failure(JMHTTPClientError.serverError))

          default: return

              completion(Result.failure(JMHTTPClientError.unexpectedError))
          }

      }).resume()
  }
}
