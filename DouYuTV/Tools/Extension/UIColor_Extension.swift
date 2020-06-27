//
//  UIColor_Extension.swift
//  DouYuTV
//
//  Created by 黄武 on 2020/6/27.
//  Copyright © 2020 黄武. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1.0) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
