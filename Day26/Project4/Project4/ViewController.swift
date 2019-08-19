//
//  ViewController.swift
//  Project4
//
//  Created by admin on 2019/8/15.
//  Copyright © 2019 limice. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "google.com"]
    var urlStr: String?
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "打开", style: .plain, target: self, action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        
        
        toolbarItems = [progressButton,spacer, refresh,forward,back]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url:URL! = URL(string: "https://\(urlStr!)")
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    @objc func openTapped() {
        let alert = UIAlertController(title: "打开网页", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            alert.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alert, animated: true)
        
    }
    func openPage(action: UIAlertAction) {
        let str = action.title
        let url = URL(string: "https://\(str!)")
        webView.load(URLRequest(url: url!))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        warning()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            //UIProgressView的progress是float,estimatedProgress是double,需要转换
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    func warning() {
        let alert = UIAlertController(title: "警告", message: "不能打开此网页", preferredStyle: .alert)
        let action = UIAlertAction(title: "关闭", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

