//
//  ViewController.swift
//  Bout Time
//
//  Created by Kate Duncan-Welke on 10/19/18.
//  Copyright © 2018 Kate Duncan-Welke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var fact1: UIButton!
    @IBOutlet weak var fact2: UIButton!
    @IBOutlet weak var fact3: UIButton!
    @IBOutlet weak var fact4: UIButton!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var learnMore: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // round left-hand corners on views
        roundCorners(view: view1, cornerRadius: 5.0)
        roundCorners(view: view2, cornerRadius: 5.0)
        roundCorners(view: view3, cornerRadius: 5.0)
        roundCorners(view: view4, cornerRadius: 5.0)
        
        resetRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Functions
    
    func resetRound() {
        // hide results and learn more buttons
        resultButton.isHidden = true
        learnMore.isHidden = true
        
        // disable buttons to go to web view
        fact1.isEnabled = false
        fact2.isEnabled = false
        fact3.isEnabled = false
        fact4.isEnabled = false
    }
    
    func roundCorners(view: UIView, cornerRadius: Double) {
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }

    // MARK: - Actions
    
    // go to web view
    @IBAction func factTap(_ sender: UIButton) {
    }
    
    // go to next round
    @IBAction func nextRound(_ sender: UIButton) {
    }
    
}

