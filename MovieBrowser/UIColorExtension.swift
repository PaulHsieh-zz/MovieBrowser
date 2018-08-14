//
//  UIColorExtension.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/14.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func colorWith(Red red:CGFloat, Green green:CGFloat, Blue blue:CGFloat, Alpha alpha:CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: alpha)
    }
    
    static let mainDark = UIColor.colorWith(Red: 37, Green: 37, Blue: 37, Alpha: 1)
}
