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
    setUpdelegate()
  }
  
  var name: String?
  
  var count: String?
  
  lazy var  contentTextField: UITextField = {
    
    let contentTextField = UITextField()
    
    contentTextField.placeholder = "欲搜尋內容"
    
    contentTextField.textAlignment = .left
    
    return contentTextField
  }()
  
  lazy var countTextField: UITextField = {
    
    let countTextField = UITextField()
    
    countTextField.delegate = self
    
    countTextField.keyboardType = .numberPad
    
    countTextField.placeholder = "每筆呈現數量"
    
    countTextField.textAlignment = .left
    
    return countTextField
  }()
  
  let confirmButton: UIButton = {
    
    let confirmBtn = UIButton()
    
    confirmBtn.setTitle("搜尋", for: .normal)
    
    confirmBtn.backgroundColor = UIColor.lightGray
    
//    confirmBtn.isEnabled = false
    
    confirmBtn.addTarget(self, action: #selector(searchResult), for: .touchUpInside)
    
    return confirmBtn
  }()
  
  @objc func searchResult() {
    performSegue(withIdentifier: "searchResult", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
  }
  
  func setUpdelegate() {
    
    contentTextField.delegate = self
    countTextField.delegate = self
    
  }
  
  func setUpView() {
    
    navigationItem.title = "搜尋輸入頁"
    
    view.addSubview(contentTextField)
    contentTextField.layer.borderColor = UIColor.lightGray.cgColor
    contentTextField.layer.borderWidth = 1.0
    contentTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      contentTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      contentTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      contentTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
    ])
    
    view.addSubview(countTextField)
    countTextField.layer.borderColor = UIColor.lightGray.cgColor
    countTextField.layer.borderWidth = 1.0
    countTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      countTextField.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: 20),
      countTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      countTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
    ])
    
    view.addSubview(confirmButton)
    confirmButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      confirmButton.topAnchor.constraint(equalTo: countTextField.bottomAnchor, constant: 20),
      confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
      confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
    ])
    
  }
}

extension ViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    print("2133")
    
    if textField == contentTextField {

      guard let context = textField.text else { return }

      if !context.isEmptyOrWhitespace() {

        print("name")

        self.name = context

      }

    } else if textField == countTextField {

      guard let count = textField.text else { return }

      if !count.isEmptyOrWhitespace() {

        print("count")

        self.count = count

      }
    }
    
  }
  
}

