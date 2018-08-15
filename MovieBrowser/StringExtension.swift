//
//  StringExtension.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/14.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import Foundation

extension String {
    func localized(tableName: String? = nil) -> String {
        if let name = tableName {
            return NSLocalizedString(self, tableName: name, bundle: Bundle.main, value: "", comment: "")
        }
        else {
            return NSLocalizedString(self, comment: "")
        }
    }
    
}
