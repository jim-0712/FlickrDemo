//
//  KingFisherWrapper.swift
//  Errand
//
//  Created by Jim on 2020/1/30.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func loadImage(_ urlString: String?, placeHolder: UIImage) {

        guard urlString != nil else {
          
        self.image = placeHolder
          
        return }
        
        let url = URL(string: urlString!)

        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
