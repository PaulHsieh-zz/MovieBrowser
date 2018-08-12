//
//  MainSceneTableViewCell.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

struct MainSceneTableViewCellModel {
    var posterUrlString:String?
    var movieMainLanguageTitle:String?
    var movieEngTitle:String?
    var movieDate:String?
}

class MainSceneTableViewCell: UITableViewCell {

    @IBOutlet weak private var moviePosterImageView: UIImageView!
    @IBOutlet weak private var movieMainLanguageLabel: UILabel!
    @IBOutlet weak private var movieEngLabel: UILabel!
    @IBOutlet weak private var movieDateLabel: UILabel!
    
    var viewModel: MainSceneTableViewCellModel = MainSceneTableViewCellModel(posterUrlString: nil,
                                                                             movieMainLanguageTitle: nil,
                                                                             movieEngTitle: nil,
                                                                             movieDate: nil) {
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
        
        
        movieMainLanguageLabel.text = viewModel.movieMainLanguageTitle ?? "Unknown"
        movieEngLabel.text = viewModel.movieEngTitle ?? "Unknown"
        movieDateLabel.text = viewModel.movieDate ?? "Unknown"
        
    }
}
