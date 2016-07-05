//
//  ViewController.swift
//  Knocknock
//
//  Created by Wenxiang Deng on 7/1/16.
//  Copyright © 2016 Wenxiang Deng. All rights reserved.
//

import UIKit
import WebKit

let PROCESS_POOL = "MainProcessPool"


class ViewController: UIViewController, UIWebViewDelegate {
    var mainWebView:UIWebView!
    //ff5722
    //98205027
    @IBOutlet weak var fresher: UIActivityIndicatorView!
    @IBOutlet weak var refreshApp: UIButton!
    @IBOutlet weak var noNetLabel: UILabel!
    
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let url = NSURL(string: "http://granny.io:3000")!
        
        //let policy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        //let request = NSURLRequest(URL: url, cachePolicy: policy, timeoutInterval: 5)
        var frame = UIScreen.mainScreen().bounds
        frame.size.height -= UIApplication.sharedApplication().statusBarFrame.height
        frame.origin.y += UIApplication.sharedApplication().statusBarFrame.height
        
        ///   SHOULD SETUP COOKIES
        let config = WKWebViewConfiguration()
        config.processPool = WKProcessPool()
        mainWebView = UIWebView(frame: frame)
        
        //mainWebView.navigationDelegate = self
        if let url = NSURL(string: "https://granny.io") {
            let req = NSMutableURLRequest(URL: url)
            mainWebView.loadRequest(req)
        }
        
        mainWebView.delegate = self
        mainWebView.scrollView.bounces = false  //TODO: temporary
        view.addSubview(mainWebView)
        mainWebView.hidden = true
        refreshApp.hidden = true
        noNetLabel.hidden = true
        
        //timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ViewController.checkCookies), userInfo: nil, repeats: true)
    }
    
//    func checkCookies() {
//        print(NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies)
//    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubviewToFront(mainWebView)
        fresher.hidden = false
        fresher.startAnimating()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        fresher.stopAnimating()
        fresher.hidden = true
        mainWebView.hidden = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        fresher.stopAnimating()
        fresher.hidden = true
        refreshApp.hidden = false
        noNetLabel.hidden = false
    }

    @IBAction func appRefresh(sender: UIButton) {
        refreshApp.hidden = true
        noNetLabel.hidden = true
        fresher.hidden = false
        fresher.startAnimating()
        if let url = NSURL(string: "https://granny.io") {
            let req = NSURLRequest(URL: url)
            mainWebView.loadRequest(req)
        }
    }
}










