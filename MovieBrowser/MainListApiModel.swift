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

func MainListApiFeed(apiKey:String, page:Int, sortBy:DiscoverMovieSoryBy) -> [String:AnyObject] {
    return ["api_key": apiKey, "page": page, "sort_by":sortBy.rawValue, "language":Constant.languageCode] as [String:AnyObject]
}

struct MainListResponseModel {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [[String:AnyObject]]
    
    init(feed:[String:AnyObject]) {
        self.page = feed["page"] as? Int ?? 0
        self.total_results = feed["total_results"] as? Int ?? 0
        self.total_pages = feed["total_pages"] as? Int ?? 0
        self.results = feed["results"] as? [[String:AnyObject]] ?? []
    }
}

struct MainListDataModel {
    var posterPath: String
    var backdropPath: String
    var popularity: Double
    var originalTitle: String
    var title: String
    var date: String
    var movieId: Int
    
    init(feed: [String:AnyObject]) {
        self.posterPath = feed["poster_path"] as? String ?? ""
        self.backdropPath = feed["backdrop_path"] as? String ?? ""
        self.popularity = feed["popularity"] as? Double ?? 0.0
        self.originalTitle = feed["original_title"] as? String ?? ""
        self.title = feed["title"] as? String ?? ""
        self.date = feed["release_date"] as? String ?? ""
        self.movieId = feed["id"] as? Int ?? 0
    }
}
