//
//  MovieBookingWebViewController.swift
//  MovieBrowser
//
//  Created by Paul Hsieh on 2018/8/15.
//  Copyright © 2018年 PaulHsieh. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class MovieBookingWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webViewContainer: UIView!
    var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWebView()
        SVProgressHUD.show()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    func setWebView () {
        // It cannot using WKWebView on nib directly before iOS 11, and this app is support from iOS 10, so init it programmatically
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: self.webViewContainer.bounds, configuration: webConfiguration)
        webView.navigationDelegate = self
        self.webViewContainer.addSubview(webView)
        setupWKWebViewConstraints()
        
        let loadingUrl = URL(string: Constant.movieBookingUrl)
        let myRequest = URLRequest(url: loadingUrl!)
        webView.load(myRequest)
    }
    
    func setupWKWebViewConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: webViewContainer.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: webViewContainer.trailingAnchor, constant: 0).isActive = true
    }

    
    // MARK:- WKWebViewDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}
