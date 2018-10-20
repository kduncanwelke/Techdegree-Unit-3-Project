//
//  Sounds.swift
//  Bout Time
//
//  Created by Kate Duncan-Welke on 10/20/18.
//  Copyright © 2018 Kate Duncan-Welke. All rights reserved.
//

import Foundation
import AudioToolbox

class Sound {
    let number: SystemSoundID
    let resourceName: String
    let type: String
    
    init(number: SystemSoundID, resourceName: String, type: String) {
        self.number = number
        self.resourceName = resourceName
        self.type = type
    }
    
    static func loadSound(number: inout SystemSoundID, resourceName: String, type: String) {
        let path = Bundle.main.path(forResource: resourceName, ofType: type)
        let soundURL = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &number)
    }
    
    static func playSound(number: SystemSoundID) {
        AudioServicesPlaySystemSound(number)
    }
    
    let correctSound = Sound(number: 0, resourceName: "CorrectDIng", type: "wav")
    let incorrectSound = Sound(number: 1, resourceName: "IncorrectBuzz", type: "wav")
}
