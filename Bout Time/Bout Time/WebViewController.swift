//
//  WebViewController.swift
//  Bout Time
//
//  Created by Dennis Parussini on 25.10.18.
//  Copyright © 2018 Kate Duncan-Welke. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension WebViewController: WKNavigationDelegate {}
