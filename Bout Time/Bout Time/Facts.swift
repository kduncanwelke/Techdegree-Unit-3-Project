//
//  Facts.swift
//  Bout Time
//
//  Created by Kate Duncan-Welke on 10/19/18.
//  Copyright © 2018 Kate Duncan-Welke. All rights reserved.
//

import Foundation
import GameKit

class Fact {
    let factText: String
    let year: Int
    let moreInfo: URL?
    
    init(factText: String, year: Int, moreInfo: URL?) {
        self.factText = factText
        self.year = year
        self.moreInfo = moreInfo
    }
    
    static func shuffleFacts() -> [Fact]? {
        let facts = loadFacts()
        guard let shuffledFacts = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: facts) as? [Fact] else {
            return nil
        }
        return shuffledFacts
    }
    
    static func loadFacts() -> [Fact] {
        return [
            Fact(factText: "The Olympics are founded", year: -776, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/athl/hd_athl.htm")),
            Fact(factText: "The Greeks begin establishing colonies in southern Italy", year: -750, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/angk/hd_angk.htm")),
            Fact(factText: "The earliest known first Greek lyric poets write", year: -650, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/grmu/hd_grmu.htm")),
            Fact(factText: "Sappho is active, some poetry honors Aphrodite", year: -610, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/grlg/hd_grlg.htm")),
            Fact(factText: "The theatre at Syracuse is constructed", year: -550, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/thtr/hd_thtr.htm")),
            Fact(factText: "The red-figure pottery method is created", year: -525, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/vase/hd_vase.htm")),
            Fact(factText: "The Greeks fight off a Persian attack", year: -490, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/acha/hd_acha.htm")),
            Fact(factText: "The Delian league is founded after the Persian Wars", year: -477, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/gwar/hd_gwar.htm")),
            Fact(factText: "The Parthenon is built", year: -449, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/grarc/hd_grarc.htm")),
            Fact(factText: "Greek style temples are built at Agrigentum", year: -430, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/grarc/hd_grarc.htm")),
            Fact(factText: "Wet-drapery parapet added to Temple of Athena Nike", year: -420, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/god2/hd_god2.htm")),
            Fact(factText: "The second largest theatre is built in Tauromenium", year: -403, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/thtr/hd_thtr.htm")),
            Fact(factText: "Socrates is sentenced to death by deadly hemlock", year: -399, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/dbag/hd_dbag.htm")),
            Fact(factText: "Plato founds the Academy at Athens", year: -380, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/ipha/hd_ipha.htm")),
            Fact(factText: "Alexander the Great dies", year: -323, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/alex/hd_alex.htm")),
            Fact(factText: "The Romans attack, destroying the Archaean Confederacy and taking over Greece", year: -146, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/romr/hd_romr.htm")),
            Fact(factText: "Pompey is defeated by Julius Caesar", year: -48, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/roru/hd_roru.htm")),
            Fact(factText: "The Triumvirate defeats the Republicans at Philippi", year: -43, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/romr/hd_romr.htm")),
            Fact(factText: "Octavian (Augustus) wins at the Battle of Actium", year: -32, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/augs/hd_augs.htm")),
            Fact(factText: "Roman Emperor Domitian makes peace with the Dacians", year: 85, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/flav/hd_flav.htm")),
            Fact(factText: "Trajan wins in the first and second Dacian wars", year: 101, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/roem/hd_roem.htm")),
            Fact(factText: "The Goths raid Greece", year: 257, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/barb/hd_barb.htm")),
            Fact(factText: "Diocletian reorganizes the Roman Empire", year: 293, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/roem/hd_roem.htm")),
            Fact(factText: "Theodosius orders the closing of pagan temples", year: 391, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/athl/hd_athl.htm")),
            Fact(factText: "The Olympics cease when the Temple of Zeus burns down", year: 426, moreInfo: URL(string: "https://www.metmuseum.org/toah/hd/grarc/hd_grarc.htm"))
        ]
    }
}

/* Fact Sources
“Ancient Greece, 1000 B.C.–1 A.D.” In Heilbrunn Timeline of Art History. New York: The Metropolitan Museum of Art, 2000–. http://www.metmuseum.org/toah/ht/?period=04&region=eusb (October 2000)
 
 “Ancient Greece, 1–500 A.D.” In Heilbrunn Timeline of Art History. New York: The Metropolitan Museum of Art, 2000–. http://www.metmuseum.org/toah/ht/?period=05&region=eusb (October 2000)
*/










