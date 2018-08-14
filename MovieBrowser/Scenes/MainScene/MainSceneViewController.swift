//
//  MainSceneViewController.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit
import SDWebImage

class MainSceneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    var currentPage: Int = 0
    var totalPages: Int = Int.max
    var perPage: Int = 0
    var isLoading: Bool = false
    var sourceArray:[MainListDataModel] = []
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.pullToRefreshAction),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor(white: 0.9, alpha: 0.9)
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.mainDark
        initTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func initTable() {
        let cellNib = UINib(nibName: "MainSceneTableViewCell", bundle: nil)
        listTableView.register(cellNib, forCellReuseIdentifier: MainSceneTableViewCell.cellIdentifier)
        listTableView.refreshControl = refreshControl
        listTableView.backgroundColor = UIColor.mainDark
    }
    
    func loadData() {
        if currentPage < totalPages {
            let feed = MainListApiFeed(apiKey: Constant.apiKey,
                                       page: currentPage + 1,
                                       sortBy: .release_date_desc)
            isLoading = true
            NetworkManager.Get.request(Name: .list, Parameter: feed, Path: nil) {
                [weak self] responseModel in
                self?.isLoading = false
                self?.refreshControl.endRefreshing()
                if let responseData = responseModel.response, responseModel.success == true {
                    let listModel = MainListResponseModel(feed: responseData)
                    self?.sourceArray.append(contentsOf:
                        listModel.results.map {
                        MainListDataModel(feed: $0)
                    })
                    self?.currentPage = listModel.page
                    self?.totalPages = listModel.total_pages
                    self?.perPage = listModel.results.count
                    self?.listTableView.reloadData()
                }
                else {
                    // TODO: failed alert
                    print("failed")
                }
                
            }
        }
    }
    
    @objc func pullToRefreshAction() {
        currentPage = 0
        totalPages = Int.max
        sourceArray.removeAll()
        loadData()
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainSceneTableViewCell.cellIdentifier) as! MainSceneTableViewCell
        
        let dataModel = sourceArray[indexPath.row]
        cell.viewModel = MainSceneTableViewCellModel(moviewOriginTitle: dataModel.originalTitle,
                                                     movieTitle: dataModel.title,
                                                     movieDate: dataModel.date,
                                                     popularity: dataModel.popularity)
        
        if dataModel.posterPath != "" {
            cell.moviePosterImageView.sd_setImage(with: URL(string: Constant.imageBaseUrl + dataModel.posterPath)!,
                                                  placeholderImage: UIImage(),
                                                  options: SDWebImageOptions(rawValue: 0),
                                                  completed:  {
                                                    (image, error, cacheType, imageURL) in
                                                    if error == nil {
                                                        cell.noImageHintLabel.isHidden = true
                                                    }
                                                    else {
                                                        cell.noImageHintLabel.isHidden = false
                                                    }
                                                  })

        }
        else {
            cell.noImageHintLabel.isHidden = false
            cell.moviePosterImageView.image = UIImage()
        }
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // pre loading
        if (indexPath.row >= sourceArray.count - perPage / 2 && currentPage < totalPages) && !isLoading {
            loadData()
        }
    }
}
