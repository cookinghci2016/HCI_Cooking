//
//  drawUIView.swift
//  HCI_recipe
//
//  Created by Jie Tan on 2/19/16.
//  Copyright © 2016 Jie Tan. All rights reserved.
//

import UIKit

class drawUIView: UIView {

   
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        let rectangle = CGRectMake(0,0,rect.width,rect.height)
        CGContextMoveToPoint(context, 5, 22)
        CGContextAddLineToPoint(context, 85, 22)
        CGContextAddRect(context, rectangle)
        CGContextStrokePath(context)
    }
    
    
    

}
