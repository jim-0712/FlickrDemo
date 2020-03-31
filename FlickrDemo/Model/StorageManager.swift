//
//  StorageManager.swift
//  STYLiSH
//
//  Created by Jim on 2019/12/17.
//  Copyright © 2019 Jim. All rights reserved.
//

import Foundation
import CoreData
import  UIKit

class StorageManager {
  static let shared = StorageManager()

  lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Favorites")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  func saveContext (favorite: Favorite) {
      let context = persistentContainer.viewContext
      let favor = Favorites(entity: Favorites.entity(), insertInto: context)
      favor.imageString = favorite.imageString
      favor.name = favorite.name
      
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
  
  func fetchData() -> [Favorites] {
    
    let context = persistentContainer.viewContext
    
    var returnData: [Favorites] = []
    
    do {
      
      returnData = try context.fetch(Favorites.fetchRequest())
      return returnData
      
    } catch {
      fatalError("\(error)")
    }
  }
  
}
