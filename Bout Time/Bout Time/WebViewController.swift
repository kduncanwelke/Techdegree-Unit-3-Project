//
//  WebViewController.swift
//  Bout Time
//
//  Created by Kate Duncan-Welke on 10/24/18.
//  Copyright © 2018 Kate Duncan-Welke. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var url: URL!
    
    @IBOutlet weak var navBar: UIButton!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: url)
        webView.load(request)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dismissWebView(_ sender: UIButton) {
        // dismiss web view when web view bar is tapped, show status bar
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
    }

}
