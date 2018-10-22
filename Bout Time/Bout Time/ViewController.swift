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

    @IBOutlet weak var learnMore: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    
    // MARK: - Properties
    var shuffledFacts = Fact.shuffleFacts()
    
    var factIndex = 0
    
    // timer properties
    var seconds = 60
    var timer = Timer()
    var isTimerOn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showFacts()
        
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
    
    // MARK: UI Updates
    
    func showFacts() {
       let buttons = [fact1, fact2, fact3, fact4]
        
        if let factArray = shuffledFacts {
            
            for button in buttons {
                let currentFact = factArray[factIndex]
                if let button = button {
                button.setTitle(currentFact.factText, for: .normal)
                factIndex += 1
                }
            }
        }
    }
    
    

    // MARK: - Custom Functions
    
    func roundCorners(view: UIView, cornerRadius: Double) {
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
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
    
    // function for when timer is running
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // run while timer is active
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = "0.\(seconds)"
        
        // if time runs out reset timer, display correct answer, load next round
        if seconds == 0 {
            timer.invalidate()
            timerLabel.text = "You ran out of time!"
            
            // increase questions asked/missed then go to next round
            //missedQuestions += 1
            //questionsAsked += 1
            
            seconds = 60
        }
    }
    
    // stop timer when answer is selected, hide label during feedback and reset counter
    func hideTimer() {
        timer.invalidate()
        timerLabel.isHidden = true
        seconds = 60
    }

    
    // MARK: - Actions
    
    // go to web view
    @IBAction func factTap(_ sender: UIButton) {
    }
    
    // go to next round
    @IBAction func nextRound(_ sender: UIButton) {
    }
    
}

