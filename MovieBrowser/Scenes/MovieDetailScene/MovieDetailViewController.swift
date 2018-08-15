//
//  MovieDetailViewController.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/15.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentVIew: UIView!
    @IBOutlet weak var moviewDetailHeaderView: MovieDetailHeaderView!
    
    @IBOutlet weak var movieDetailDescriptionView: MoviewDetailDescriptionView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var noImageHintLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var synopsisButton: UIButton!
    
    @IBOutlet var showSynopsisConstraint: NSLayoutConstraint!
    @IBOutlet var hideSynopsisConstraint: NSLayoutConstraint!
    
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
        SVProgressHUD.show()
        let feed = MovieDetailApiFeed(apiKey: Constant.apiKey)
        NetworkManager.Get.request(Name: .movieDetail, Parameter: feed, Path: String(movieId)) {
            [weak self] responseModel in
            SVProgressHUD.dismiss()
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
        
        synopsisLabel.text = viewModel.synopsis == "" ? "None".localized() : viewModel.synopsis
        synopsisButton.setTitle("Synopsis".localized(), for: .normal)
        synopsisButton.layer.masksToBounds = true
        synopsisButton.layer.cornerRadius = 6
        synopsisButton.layer.borderWidth = 1
        synopsisButton.layer.borderColor = UIColor.mainWhite.cgColor
        
        moviewDetailHeaderView.viewModel = MovieDetailHeaderViewModel(title: viewModel.title,
                                                                      originalTitle: viewModel.originalTitle,
                                                                      releaseDate: viewModel.releaseDate,
                                                                      runtime: viewModel.runtime,
                                                                      posterPath: viewModel.posterPath,
                                                                      backdropPath: viewModel.backdropPath,
                                                                      popularity: viewModel.popularity)
        moviewDetailHeaderView.bookMovie(handler: self.onClickBookMovie)
        
        movieDetailDescriptionView.viewModel = MoviewDetailDescriptionViewModel(genres: viewModel.genres,
                                                                                language: viewModel.originalLanguage,
                                                                                date: viewModel.releaseDate,
                                                                                runtime: viewModel.runtime,
                                                                                status: viewModel.status)
    }
    
    func onClickBookMovie() {
        let webVC = MovieBookingWebViewController()
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func onClickSynopsis(_ sender: Any) {
        if synopsisButton.isSelected {
            synopsisButton.isSelected = false
            hideSynopsisConstraint.isActive = true
            showSynopsisConstraint.isActive = false
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.synopsisButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                self.synopsisLabel.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        }
        else {
            synopsisButton.isSelected = true
            synopsisLabel.isHidden = false
            hideSynopsisConstraint.isActive = false
            showSynopsisConstraint.isActive = true
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.synopsisButton.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                self.synopsisLabel.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}
