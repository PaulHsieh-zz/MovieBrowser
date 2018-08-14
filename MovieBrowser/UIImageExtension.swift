//
//  UIImageExtension.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/14.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func imageWithColor(color:UIColor?) -> UIImage! {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
        if let color = color {
            
            color.setFill()
        }
        else {
            
            UIColor.white.setFill()
        }
        
        context!.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
}
