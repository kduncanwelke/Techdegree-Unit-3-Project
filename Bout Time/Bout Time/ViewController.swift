//
//  ViewController.swift
//  Bout Time
//
//  Created by Kate Duncan-Welke on 10/19/18.
//  Copyright © 2018 Kate Duncan-Welke. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var fact1: UIButton!
    @IBOutlet weak var fact2: UIButton!
    @IBOutlet weak var fact3: UIButton!
    @IBOutlet weak var fact4: UIButton!

    @IBOutlet weak var arrowButton1: UIButton!
    @IBOutlet weak var arrowButton2: UIButton!
    @IBOutlet weak var arrowButton3: UIButton!
    @IBOutlet weak var arrowButton4: UIButton!
    @IBOutlet weak var arrowButton5: UIButton!
    @IBOutlet weak var arrowButton6: UIButton!
    
    @IBOutlet weak var learnMore: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var webviewBar: UIButton!
    
    
    // MARK: - Properties
    
    var webView: WKWebView!
    
    var shuffledFacts = Fact.shuffleFacts()
    
    var factIndex = 0
    
    // indexes to track current fact assigned to each button
    var fact1Index = 0
    var fact2Index = 0
    var fact3Index = 0
    var fact4Index = 0
    
    var rounds = 0
    var correctAnswers = 0
    
    // timer properties
    var seconds = 60
    var timer = Timer()
    var isTimerOn = false
    
    
    // sounds
    let correctSound = Sound(number: 0, resourceName: "CorrectDing", type: "wav")
    let incorrectSound = Sound(number: 1, resourceName: "IncorrectBuzz", type: "wav")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // load sounds
        Sound.loadSound(number: &correctSound.number, resourceName: correctSound.resourceName, type: correctSound.type)
        Sound.loadSound(number: &incorrectSound.number, resourceName: incorrectSound.resourceName, type: incorrectSound.type)
        
        // set game counters to zero
        factIndex = 0
        rounds = 0
        correctAnswers = 0
        
        // make sure buttons to access web are inactive
        disableWebButtons()
        
        // round left-hand corners on views
        roundCorners(view: view1, cornerRadius: 5.0)
        roundCorners(view: view2, cornerRadius: 5.0)
        roundCorners(view: view3, cornerRadius: 5.0)
        roundCorners(view: view4, cornerRadius: 5.0)
        
        // display facts
        showFacts()
        
        // keep results and learn more buttons hidden until round is over
        resultButton.isHidden = true
        learnMore.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UI Updates
    
    func roundCorners(view: UIView, cornerRadius: Double) {
        // round left-hand corners of views behind text to match rounded arrow buttons
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    func disableSwitchButtons() {
        // disable fact switching buttons
        arrowButton1.isEnabled = false
        arrowButton2.isEnabled = false
        arrowButton3.isEnabled = false
        arrowButton4.isEnabled = false
        arrowButton5.isEnabled = false
        arrowButton6.isEnabled = false
    }
    
    func enableSwitchButtons() {
        // enable fact switching buttons
        arrowButton1.isEnabled = true
        arrowButton2.isEnabled = true
        arrowButton3.isEnabled = true
        arrowButton4.isEnabled = true
        arrowButton5.isEnabled = true
        arrowButton6.isEnabled = true
    }
    
    func disableWebButtons() {
        // disable buttons that go to web view
        fact1.isEnabled = false
        fact2.isEnabled = false
        fact3.isEnabled = false
        fact4.isEnabled = false
        webviewBar.isHidden = true
    }
    
    func enableWebButtons() {
        // enable buttons that go to web view
        fact1.isEnabled = true
        fact2.isEnabled = true
        fact3.isEnabled = true
        fact4.isEnabled = true
    }
    
    func hideItems() {
        // hide items when displaying web view
        stackView.isHidden = true
        resultButton.isHidden = true
        learnMore.isHidden = true
    }
    
    func showItems() {
        // show items again when web view is dismissed, hide web bar
        stackView.isHidden = false
        resultButton.isHidden = false
        learnMore.isHidden = false
        webviewBar.isHidden = true
    }
    
    func showFacts() {
        // put buttons in array
       let buttons = [fact1, fact2, fact3, fact4]
        
        if let factArray = shuffledFacts {
            
            // loop through buttons and assign text and temporary index to reference fact in array
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
        
        // show and run timer
        timerLabel.isHidden = false
        timerLabel.text = "0.\(seconds)"
        runTimer()
    }
    
    func resetRound() {
        // reset ui, turning off web buttons, enable arrow switching, show next fact
        disableWebButtons()
        enableSwitchButtons()
        showFacts()
        
        // hide results and learn more buttons (will toggle on again when round ends)
        resultButton.isHidden = true
        learnMore.isHidden = true
    }
    

    // MARK: - Custom Functions
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        // respond to device shake motion
        showResult()
    }
    
    func checkAnswer() -> Bool? {
        // check that each fact's year is less than the previous (BC years are represented as negative values)
        guard let factArray = shuffledFacts else { return nil }
        if factArray[fact1Index].year < factArray[fact2Index].year && factArray[fact2Index].year < factArray[fact3Index].year && factArray[fact3Index].year < factArray[fact4Index].year {
            rounds += 1
            correctAnswers += 1
            Sound.playSound(number: correctSound.number)
            return true
        } else {
            rounds += 1
            Sound.playSound(number: incorrectSound.number)
            return false
        }
    }
    
    func showResult() {
        let answer = checkAnswer()
        
        // change result button image based on correct/incorrect answer
        if let chosenAnswer = answer {
            if chosenAnswer {
                resultButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
                resultButton.isHidden = false
            } else {
                resultButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
                resultButton.isHidden = false
            }
        }
        
        // turn off button switching, as round is ended and user should no longer be able to change answer
        disableSwitchButtons()
        
        // hide timer, show learn more label, and enable buttons to web view
        learnMore.isHidden = false
        enableWebButtons()
        hideTimer()
    }
    
    // function for when timer is running
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    // run while timer is active
    @objc func updateTimer() {
        seconds -= 1
        timerLabel.text = "0.\(seconds)"
        
        // if time runs out reset timer, display correctness of answer
        if seconds == 0 {
            timer.invalidate()
            
            showResult()
            
            // increase round count
            rounds += 1
            seconds = 60
        }
    }
    
    // stop timer when answer is submitted, hide timer label during feedback and reset seconds
    func hideTimer() {
        timer.invalidate()
        timerLabel.isHidden = true
        seconds = 60
    }
    
    func loadWebsite(url: URL) {
        // run when fact is tapped at end of round
        let request = URLRequest(url: url)
        webView = WKWebView(frame: self.view.frame)
        webView.navigationDelegate = self
        webView.load(request)
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
        
        // hide stack view etc, show web view bar, hide status bar
        hideItems()
        webviewBar.isHidden = false
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
    }

    
    // MARK: - Actions
    
    @IBAction func factSwap(_ sender: UIButton) {
        // behavior to swap facts when arrows are pressed, exchanging array indexes to maintain proper reference to each fact in array
        switch sender.tag {
        case 1, 2: // swap between first and second fact
            (fact1Index, fact2Index) = (fact2Index, fact1Index)
            if let factArray = shuffledFacts {

                fact1.setTitle(factArray[fact1Index].factText, for: .normal)
                fact2.setTitle(factArray[fact2Index].factText, for: .normal)
            }
        case 3, 4: // swap between second and third fact
            (fact2Index, fact3Index) = (fact3Index, fact2Index)
            if let factArray = shuffledFacts {
                
                fact2.setTitle(factArray[fact2Index].factText, for: .normal)
                fact3.setTitle(factArray[fact3Index].factText, for: .normal)
            }
        case 5, 6: // swap between third and fourth fact
            (fact3Index, fact4Index) = (fact4Index, fact3Index)
            if let factArray = shuffledFacts {
                
                fact3.setTitle(factArray[fact3Index].factText, for: .normal)
                fact4.setTitle(factArray[fact4Index].factText, for: .normal)
            }
        default:
            break
        }
    }
    
    @IBAction func factTap(_ sender: UIButton) {
        // go to web view, loading index to access fact and its url property
        switch sender.tag {
        case 1:
            if let factArray = shuffledFacts {
                guard let url = factArray[fact1Index].moreInfo else { return }
                loadWebsite(url: url)
            }
        case 2:
            if let factArray = shuffledFacts {
                guard let url = factArray[fact2Index].moreInfo else { return }
                loadWebsite(url: url)
            }
        case 3:
            if let factArray = shuffledFacts {
                guard let url = factArray[fact3Index].moreInfo else { return }
                loadWebsite(url: url)
            }
        case 4:
            if let factArray = shuffledFacts {
                guard let url = factArray[fact4Index].moreInfo else { return }
                loadWebsite(url: url)
            }
        default: break
        }
    }

    @IBAction func dismissWebView(_ sender: UIButton) {
        // dismiss web view when web view bar is tapped, show stack view etc again, show status bar
        webView.removeFromSuperview()
        showItems()
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
    }
    
    @IBAction func nextRound(_ sender: UIButton) {
        // go to next round if six rounds have not been achieved, otherwise segue to results
        if rounds != 6 {
            resetRound()
        } else {
            performSegue(withIdentifier: "resultsSegue", sender: (Any).self)
        }
    }
    
    // prepare for segue to results screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is resultViewController {
            let destinationViewController = segue.destination as? resultViewController
            destinationViewController?.finalScore = correctAnswers
        }
    }
    
    
}

