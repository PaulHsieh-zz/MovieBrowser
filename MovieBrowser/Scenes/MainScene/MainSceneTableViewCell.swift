//
//  MainSceneTableViewCell.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

struct MainSceneTableViewCellModel {
    var posterUrlString: String?
    var moviewOriginTitle: String?
    var movieTitle: String?
    var movieDate: String?
    var popularity: Double?
}

class MainSceneTableViewCell: UITableViewCell {

    @IBOutlet weak private var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieOriginTitle: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak private var movieDateLabel: UILabel!
    
    var viewModel: MainSceneTableViewCellModel =
        MainSceneTableViewCellModel(posterUrlString: nil,
                                    moviewOriginTitle: nil,
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
        if let posterUrlString = viewModel.posterUrlString {
            moviePosterImageView.image = UIImage(named: posterUrlString)
        }
        else {
            moviePosterImageView.image = UIImage(named: "img_placeholder")
        }
        
        
        movieOriginTitle.text = viewModel.moviewOriginTitle ?? "Unknown"
        movieTitle.text = viewModel.movieTitle ?? "Unknown"
        movieDateLabel.text = viewModel.movieDate ?? "Unknown"
        
    }
}
