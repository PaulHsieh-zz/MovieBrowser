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
    
    @IBOutlet weak var moviewDetailDescriptionVIew: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollContentVIew.backgroundColor = UIColor.mainDark
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
