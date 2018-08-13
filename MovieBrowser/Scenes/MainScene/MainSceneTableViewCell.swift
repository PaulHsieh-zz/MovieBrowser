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
        movieOriginTitle.text = viewModel.moviewOriginTitle ?? "Unknown"
        movieTitle.text = viewModel.movieTitle ?? "Unknown"
        movieDateLabel.text = viewModel.movieDate ?? "Unknown"
        
    }
}
