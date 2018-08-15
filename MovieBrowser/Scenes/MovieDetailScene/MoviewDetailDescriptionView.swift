//
//  MoviewDetailDescriptionView.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/15.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

class MoviewDetailDescriptionView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var genresDetailLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageDetailLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateDetailLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var runtimeDetailLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusDetailLabel: UILabel!
    
    var viewModel: MoviewDetailDescriptionViewModel! {
        didSet {
            self.setupUI()
        }
    }
    
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
        
        genresLabel.text = "Genres".localized()
        genresDetailLabel.text = ""
        languageLabel.text = "Language".localized()
        languageDetailLabel.text = ""
        dateLabel.text = "Release Date".localized()
        dateDetailLabel.text = ""
        runtimeLabel.text = "runtime".localized()
        runtimeDetailLabel.text = ""
        statusLabel.text = "status".localized()
        statusDetailLabel.text = ""
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MoviewDetailDescriptionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    private func setupUI() {
        if viewModel.genres.count > 0 {
            genresDetailLabel.text = viewModel.genres.joined(separator: ",")
        }
        else {
            genresDetailLabel.text = "Unknown".localized()
        }
        
        if viewModel.language.count > 0 {
            languageDetailLabel.text = viewModel.language
        }
        else {
            languageDetailLabel.text = "Unknown".localized()
        }
        
        dateDetailLabel.text = viewModel.date == "" ? "Unknown".localized() : viewModel.date
        runtimeDetailLabel.text = viewModel.runtime == 0 ? "Unknown".localized() : String(viewModel.runtime)
        statusDetailLabel.text = viewModel.status == "" ? "Unknown".localized() : viewModel.status
    }

}
