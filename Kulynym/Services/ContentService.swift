/*
 * Kulynym
 * ItemContentService.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

struct Section {
    var name: String
    var scenesNames = [String]()
    var scenesTimepoints = [Int]()
    var contentNames: [String]?
}

class Playlist {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Story: Playlist {
    var backgroundName: String
    var character: String
    var timepoints: [Int]
    
    init(name: String, bg: String, character: String, timepoints: [Int]) {
        self.backgroundName = bg
        self.character = character
        self.timepoints = timepoints
        super.init(name: name)
    }
}

struct ContentService {
    static let sections = [
        alphabetSection,
        numbersSection,
        animalsSection,
        plantsSection,
        karaokeSection,
        storyTalesSection,
        drawingSection,
    ]
    
    static let audios = [
        kuyrmash,
    ]
    
    static let stories = [
        kolobokStory,
    ]
    
    private static let alphabetSection = Section(name: "alphabet", scenesNames: ["AlphaS1", "AlphaS2", "AlphaS3"], scenesTimepoints: [10, 20], contentNames: ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"])
    private static let numbersSection = Section(name: "numbers", scenesNames: [""], scenesTimepoints: [0], contentNames: [""])
    private static let animalsSection = Section(name: "animals", scenesNames: [""], scenesTimepoints: [0], contentNames: [""])
    private static let plantsSection = Section(name: "plants", scenesNames: [""], scenesTimepoints: [0], contentNames: [""])
    private static let karaokeSection = Section(name: "karaoke", scenesNames: [""], scenesTimepoints: [0], contentNames: nil)
    private static let storyTalesSection = Section(name: "stories", scenesNames: [""], scenesTimepoints: [0], contentNames: nil)
    private static let drawingSection = Section(name: "drawing", scenesNames: [""], scenesTimepoints: [0], contentNames: nil)
    
    private static let kolobokStory = Story(name: "kolobok", bg: "kolobokBg", character: "kolobok", timepoints: [0])
    
    private static let kuyrmash = Playlist(name: "kuyrmash")
}
