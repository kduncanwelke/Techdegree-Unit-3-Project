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
    
    var fact1Index = 0
    var fact2Index = 0
    var fact3Index = 0
    var fact4Index = 0
    
    
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
                
                switch button {
                case fact1:
                    fact1Index = factIndex
                case fact2:
                    fact2Index = factIndex
                case fact3:
                    fact3Index = factIndex
                case fact4:
                    fact4Index = factIndex
                default:
                    break
                }
                    
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
    
    @IBAction func factSwap(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            (fact1Index, fact2Index) = (fact2Index, fact1Index)
            if let factArray = shuffledFacts {

            fact1.setTitle(factArray[fact1Index].factText, for: .normal)
            fact2.setTitle(factArray[fact2Index].factText, for: .normal)
            }
        case 2:
            (fact2Index, fact1Index) = (fact1Index, fact2Index)
            if let factArray = shuffledFacts {
                
            fact1.setTitle(factArray[fact2Index].factText, for: .normal)
            fact2.setTitle(factArray[fact1Index].factText, for: .normal)
            }
        case 3:
            (fact2Index, fact3Index) = (fact3Index, fact2Index)
            if let factArray = shuffledFacts {
                
                fact2.setTitle(factArray[fact2Index].factText, for: .normal)
                fact3.setTitle(factArray[fact3Index].factText, for: .normal)
            }
        case 4:
            (fact3Index, fact2Index) = (fact2Index, fact3Index)
            if let factArray = shuffledFacts {
                
                fact2.setTitle(factArray[fact3Index].factText, for: .normal)
                fact3.setTitle(factArray[fact2Index].factText, for: .normal)
            }
        case 5:
            (fact3Index, fact4Index) = (fact4Index, fact3Index)
            if let factArray = shuffledFacts {
                
                fact3.setTitle(factArray[fact3Index].factText, for: .normal)
                fact4.setTitle(factArray[fact4Index].factText, for: .normal)
            }
        case 6:
            (fact4Index, fact3Index) = (fact3Index, fact4Index)
            if let factArray = shuffledFacts {
                
                fact3.setTitle(factArray[fact4Index].factText, for: .normal)
                fact4.setTitle(factArray[fact3Index].factText, for: .normal)
            }
        default:
            break
        }
    }
    
    
    // go to web view
    @IBAction func factTap(_ sender: UIButton) {
    }
    
    // go to next round
    @IBAction func nextRound(_ sender: UIButton) {
    }
    
}

