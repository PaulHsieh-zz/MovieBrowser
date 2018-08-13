//
//  APIModels.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import Foundation

enum DiscoverMovieSoryBy: String {
    case release_date_desc = "release_date.desc"
    case release_date_asc  = "release_date.asc"
}

func MainListApiFeed(apiKey:String, sortBy:DiscoverMovieSoryBy) -> [String:AnyObject] {
    return ["api_key": apiKey, "sortBy":sortBy.rawValue] as [String:AnyObject]
}

struct MainListResponseModel {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [[String:AnyObject]]
    
    init(feed:[String:AnyObject]) {
        self.page = feed["page"] as! Int
        self.total_results = feed["total_results"] as! Int
        self.total_pages = feed["total_pages"] as! Int
        self.results = feed["results"] as! [[String:AnyObject]]
    }
}
