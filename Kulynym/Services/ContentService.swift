/*
 * Kulynym
 * ItemContentService.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

struct EduSection {
    var name: String
    var scenesNames: [String]
    var timepoints: [Int]
    var contentNames: [String]
    
    init(name: String, scenesNames: [String], timepoints: [Int], contentNames: [String]) {
        self.name = name
        self.scenesNames = scenesNames
        self.timepoints = timepoints
        self.contentNames = contentNames
    }
}

struct ContentService {
    static let menuSections = [
        "toddlerIcon",
        "karaokeIcon",
        "storyIcon",
        "drawingIcon",
        "preschoolerIcon",
        "gamesIcon"
    ]
    
    static let toddlerSections = [
        colorsSection,
        shapesSection,
        animalsSection,
        plantsSection,
    ]
    
    static let gamesSection = [
        "torgai",
    ]
    
    static var songs = [
        "Koshakanym",
    ]
    
    static var stories = [
        "kolobokIcon",
    ]
    
    private static var colorsSection = EduSection(name: "colorsIcon", scenesNames: [""], timepoints: [0], contentNames: ["red"])
        private static var shapesSection = EduSection(name: "shapesIcon", scenesNames: [""], timepoints: [0], contentNames: ["circle"])
    private static var animalsSection = EduSection(name: "animalsIcon", scenesNames: [""], timepoints: [0], contentNames: ["cat", "dog", "bear", "eagle", "elephant"])
    private static var plantsSection = EduSection(name: "plantsIcon", scenesNames: [""], timepoints: [0], contentNames: ["rose"])
}
