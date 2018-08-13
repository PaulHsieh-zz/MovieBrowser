//
//  MainSceneTableViewCell.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit
import SDWebImage

struct MainSceneTableViewCellModel {
    var moviewOriginTitle: String?
    var movieTitle: String?
    var movieDate: String?
    var popularity: Double?
}

class MainSceneTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak private var movieOriginTitle: UILabel!
    @IBOutlet weak private var movieTitle: UILabel!
    @IBOutlet weak private var movieDateLabel: UILabel!
    @IBOutlet weak private var popularityLabel: UILabel!
    @IBOutlet weak var popularityDescLabel: UILabel!
    @IBOutlet weak var noImageHintLabel: UILabel!
    
    var viewModel: MainSceneTableViewCellModel =
        MainSceneTableViewCellModel(moviewOriginTitle: nil,
                                    movieTitle: nil,
                                    movieDate: nil,
                                    popularity: nil) {
        didSet {
            setupUI()
        }
    }
    
    static var cellIdentifier:String {
        get {
            return "MainSceneTableViewCell"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    private func setupUI() {
        if let originTitle = viewModel.moviewOriginTitle, originTitle != "" {
            movieOriginTitle.text = originTitle
        }
        else {
            movieOriginTitle.text = "Unknown".localized()
        }

        if let title = viewModel.movieTitle, title != "" {
            movieTitle.text = title
        }
        else {
            movieTitle.text = "Unknown".localized()
        }

        if let date = viewModel.movieDate, date != "" {
            movieDateLabel.text = "\("Release Date".localized()) : \(date)"
        }
        else {
            movieDateLabel.text = "Unknown".localized()
        }

        popularityDescLabel.text = "\("Popularity".localized()) : "
        
        if let popularity = viewModel.popularity {
            popularityLabel.text = "\(popularity)"
        }
        else {
            popularityLabel.text = "0.0"
        }
    }
}
