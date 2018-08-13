//
//  MainSceneViewController.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

class MainSceneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    var currentPage:Int = 0
    var totalPages:Int = Int.max
    var sourceArray:[MainListDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func initTable() {
        let cellNib = UINib(nibName: "MainSceneTableViewCell", bundle: nil)
        listTableView.register(cellNib, forCellReuseIdentifier: MainSceneTableViewCell.cellIdentifier)
    }
    
    func loadData() {
        if currentPage < totalPages {
            let feed = MainListApiFeed(apiKey: Constant.apiKey,
                                       page: currentPage + 1,
                                       sortBy: .release_date_desc)
            
            NetworkManager.Get.request(Name: .list, Parameter: feed, Path: nil) {
                [weak self] responseModel in
                if let responseData = responseModel.response, responseModel.success == true {
                    let listModel = MainListResponseModel(feed: responseData)
                    self?.sourceArray.append(contentsOf:
                        listModel.results.map {
                        MainListDataModel(feed: $0)
                    })
                    self?.currentPage = listModel.page
                    self?.totalPages = listModel.total_pages
                    self?.listTableView.reloadData()
                }
                else {
                    // TODO: failed alert
                    print("failed")
                }
                
            }
        }
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
            cell.moviePosterImageView.sd_setImage(with: URL(string: Constant.imageBaseUrl + dataModel.posterPath)!, placeholderImage: UIImage())
        }
        else {
            cell.moviePosterImageView.image = UIImage()
        }
        


        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
