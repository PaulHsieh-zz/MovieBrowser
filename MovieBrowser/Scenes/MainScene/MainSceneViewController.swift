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
    override func viewDidLoad() {
        super.viewDidLoad()
        initTable()
    }

    func initTable() {
        let cellNib = UINib(nibName: "MainSceneTableViewCell", bundle: nil)
        listTableView.register(cellNib, forCellReuseIdentifier: MainSceneTableViewCell.cellIdentifier)
    }
    
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainSceneTableViewCell.cellIdentifier) as! MainSceneTableViewCell
        if indexPath.row % 2 == 0 {
            cell.viewModel = MainSceneTableViewCellModel(posterUrlString: "test1",
                                                         movieMainLanguageTitle: "瘋狂麥斯：憤怒道",
                                                         movieEngTitle: "Crazy Max",
                                                         movieDate: "2018/09/02")
        }
        else {
            cell.viewModel = MainSceneTableViewCellModel(posterUrlString: nil,
                                                         movieMainLanguageTitle: nil,
                                                         movieEngTitle: nil,
                                                         movieDate: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
