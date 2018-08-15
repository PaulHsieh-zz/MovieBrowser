//
//  MovieDetailViewController.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/15.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentVIew: UIView!
    @IBOutlet weak var moviewDetailHeaderView: MovieDetailHeaderView!
    
    @IBOutlet weak var movieDetailDescriptionView: MoviewDetailDescriptionView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var noImageHintLabel: UILabel!
    var movieId:Int = 0
    var viewModel:MovieDetailResponseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollContentVIew.backgroundColor = UIColor.mainDark
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    init(movieId:Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func loadData() {
        let feed = MovieDetailApiFeed(apiKey: Constant.apiKey)
        NetworkManager.Get.request(Name: .movieDetail, Parameter: feed, Path: String(movieId)) {
            [weak self] responseModel in
            if let responseData = responseModel.response, responseModel.success == true {
                self?.viewModel = MovieDetailResponseModel(feed: responseData)
                self?.setupUI()
            }
            else {
                // TODO: failed alert
                print("failed")
            }
            
        }
    }
    
    func setupUI() {
        if viewModel.posterPath != "" {
            noImageHintLabel.isHidden = true
            moviePosterImageView.sd_setImage(with: URL(string: Constant.imageBaseUrl + viewModel.posterPath)!,
                                             placeholderImage: UIImage())
        }
        else {
            noImageHintLabel.isHidden = false
            moviePosterImageView.image = UIImage()
        }
        moviewDetailHeaderView.viewModel = MovieDetailHeaderViewModel(title: viewModel.title,
                                                                      originalTitle: viewModel.originalTitle,
                                                                      releaseDate: viewModel.releaseDate,
                                                                      runtime: viewModel.runtime,
                                                                      posterPath: viewModel.posterPath)
        
        movieDetailDescriptionView.viewModel = MoviewDetailDescriptionViewModel(genres: viewModel.genres,
                                                                                language: viewModel.originalLanguage,
                                                                                date: viewModel.releaseDate,
                                                                                runtime: viewModel.runtime,
                                                                                status: viewModel.status)
    }
    
}
