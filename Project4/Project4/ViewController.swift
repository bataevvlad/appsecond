//
//  ViewController.swift
//  Project4
//
//  Created by Vlad Bataev on 11/2/19.
//  Copyright © 2019 Vlad Bataev. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    var webSites = ["youtube.com", "github.com"]
    var currentSite: String = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://" + currentSite)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "<", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: ">", style: .plain, target: webView, action: #selector(webView.goForward))

        toolbarItems = [progressButton, spacer, refresh, back, forward]
        navigationController?.isToolbarHidden = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        
        for website in webSites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true) // for iPad manage;
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in webSites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        decisionHandler(.cancel)
        
        let alert = UIAlertController(title: "Heads Up!", message: "This URL is blocked", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
    
