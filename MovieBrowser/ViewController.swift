//
//  ViewController.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/13.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let vc = MainSceneViewController()
        self.present(vc, animated: true, completion: nil)
    }

}

