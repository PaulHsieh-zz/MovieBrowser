//
//  StringExtension.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/14.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
