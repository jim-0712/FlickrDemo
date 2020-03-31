//
//  ViewController.swift
//  FlickrDemo
//
//  Created by Jim on 2020/3/30.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import IQKeyboardManager

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setUpView()
    setUpBtnEnable()
  }
  
  var text: String?
  
  var perPage: Int?
  
  var canSearch = false
  
  lazy var  contentTextField: UITextField = {
    let contentTextField = UITextField()
    contentTextField.placeholder = Search.searchContent.rawValue
    contentTextField.addTarget(self, action: #selector(checkTextField(sender:)), for: .editingChanged)
    contentTextField.textAlignment = .left
    contentTextField.translatesAutoresizingMaskIntoConstraints = false
    return contentTextField
  }()
  
  lazy var countTextField: UITextField = {
    let countTextField = UITextField()
    countTextField.addTarget(self, action: #selector(checkTextField(sender:)), for: .editingChanged)
    countTextField.keyboardType = .numberPad
    countTextField.placeholder = Search.searchCount.rawValue
    countTextField.textAlignment = .left
    countTextField.translatesAutoresizingMaskIntoConstraints = false
    return countTextField
  }()
  
  lazy var confirmButton: UIButton = {
    let confirmBtn = UIButton()
    confirmBtn.setTitle(Search.search.rawValue, for: .normal)
    confirmBtn.translatesAutoresizingMaskIntoConstraints = false
    confirmBtn.addTarget(self, action: #selector(searchResult), for: .touchUpInside)
    return confirmBtn
  }()
  
  @objc func checkTextField(sender: UITextField) {

    if sender == contentTextField {

      guard let context = sender.text else {
        
        return
      }

      if !context.isEmptyOrWhitespace() {

        self.text = context

      }

    } else if sender == countTextField {

      guard let count = sender.text else {
        
        return
      }

      if !count.isEmptyOrWhitespace() {

        self.perPage = Int(count)

      }
    }
    
    guard let _ = self.text,
          let _ = self.perPage else {
            
          canSearch = false
            
          setUpBtnEnable()
        return
    }
    
    canSearch =  true
    
    setUpBtnEnable()
  }
  
  @objc func searchResult() {
    
    let storyboard = UIStoryboard.init(name: SearchResult.searchResultVC.storyBoardName, bundle: nil).instantiateViewController(identifier: SearchResult.searchResultVC.storyBoardIdentifier)
    guard let result = storyboard as? SearchResultViewController,
          let text = self.text,
          let perPage = self.perPage else {
            
            return
    }
    result.searchCondition = APIDataItem(name: text, limit: perPage)
    navigationController?.pushViewController(result, animated: true)

  }
  
  func setUpBtnEnable() {
    if canSearch {
      
      confirmButton.isEnabled = true
      
      confirmButton.backgroundColor = UIColor.blue
    } else {
      confirmButton.isEnabled = false
      
      confirmButton.backgroundColor = UIColor.lightGray
    }
  }
  
  
  func setUpView() {
    
    navigationItem.title = "搜尋輸入頁"
    
    view.addSubview(contentTextField)
    contentTextField.layer.borderColor = UIColor.lightGray.cgColor
    contentTextField.layer.borderWidth = 1.0
    NSLayoutConstraint.activate([
      contentTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      contentTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      contentTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      contentTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
    ])
    
    view.addSubview(countTextField)
    countTextField.layer.borderColor = UIColor.lightGray.cgColor
    countTextField.layer.borderWidth = 1.0
    NSLayoutConstraint.activate([
      countTextField.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 20),
      countTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      countTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
    ])
    
    view.addSubview(confirmButton)
    NSLayoutConstraint.activate([
      confirmButton.topAnchor.constraint(equalTo: countTextField.bottomAnchor, constant: 20),
      confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
    ])
  }
  
  
}
