//
//  IngridentTypes.swift
//  HCI_recipe
//
//  Created by allen woo on 2/22/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class IngridentTypes: NSObject {
    var Ingtype: String
    var photo: UIImage?
    var sub_imgs :[UIImage] = []
    
    
// Mark: Initialization;   Append image using name array
    init?(type: String, photo: UIImage?, sub_names: [String]) {
        self.Ingtype = type
        self.photo = photo
        sub_imgs.append(photo!)
        for img_name in sub_names {
            sub_imgs.append(UIImage(named:img_name)!)
    }
//        if type.isEmpty {
//            return nil
//        }
    }
}