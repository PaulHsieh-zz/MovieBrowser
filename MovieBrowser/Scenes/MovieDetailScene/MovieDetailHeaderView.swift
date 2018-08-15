//
//  MovieDetailHeaderView.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/15.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

class MovieDetailHeaderView: UIView {

    @IBOutlet var view: UIView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterAlphaCoverView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOriginTitle: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var popularityDetailLabel: UILabel!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var blurView: UIVisualEffectView!
    var viewModel:MovieDetailHeaderViewModel! {
        didSet {
            self.setupUI()
        }
    }
    
    var bookMovie: () -> Void = { _ in }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        view.backgroundColor = UIColor.mainDark
        addSubview(view)
        
        posterImageView.image = UIImage()
        movieTitle.text = ""
        movieOriginTitle.text = ""
        popularityLabel.text = ""
        popularityDetailLabel.text = ""
        bookingButton.layer.masksToBounds = true
        bookingButton.layer.cornerRadius = 6
        bookingButton.layer.borderWidth = 1
        bookingButton.layer.borderColor = UIColor.mainWhite.cgColor
        bookingButton.setTitle("Booking".localized(), for: .normal)
        blurView.layer.masksToBounds = true
        blurView.layer.cornerRadius = 6

    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MovieDetailHeaderView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

    private func setupUI() {
        movieTitle.text = viewModel.title
        movieOriginTitle.text = viewModel.originalTitle
        popularityLabel.text = "Popularity".localized() + " : "
        popularityDetailLabel.text = String(viewModel.popularity)
        bookingButton.isEnabled = true
        
        // backdrop > poster > none
        if viewModel.backdropPath != "" {
            posterImageView.sd_setImage(with: URL(string: Constant.imageBaseUrl + viewModel.backdropPath)!,
                                        placeholderImage: UIImage())
        }
        else if viewModel.posterPath != "" {
            posterImageView.sd_setImage(with: URL(string: Constant.imageBaseUrl + viewModel.posterPath)!,
                                        placeholderImage: UIImage())
        }
        else {
            posterImageView.image = UIImage()
        }
    }
    
    @IBAction func onClickBooking(_ sender: Any) {
        self.bookMovie()
    }
    
    public func bookMovie( handler: @escaping () -> Void ) {
        self.bookMovie = handler
    }
}
