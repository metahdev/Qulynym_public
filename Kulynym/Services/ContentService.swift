/*
 * Kulynym
 * ItemContentService.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import Foundation

class Section {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

class EduSection: Section {
    var scenesNames: [String]
    var timepoints: [Int]
    var contentNames: [String]
    
    init(name: String, scenesNames: [String], timepoints: [Int], contentNames: [String]) {
        self.scenesNames = scenesNames
        self.timepoints = timepoints
        self.contentNames = contentNames
        super.init(name)
    }
}

class StorySection: Section {
    
}

struct ContentService {
    static let menuSections = [
        Section("toddlerIcon"),
        Section("karaokeIcon"),
        Section("storyIcon"),
        Section("drawingIcon"),
        Section("preschoolerIcon"),
        Section("gamesIcon")
    ]
    
    static let toddlerSections = [
        colorsSection,
        shapesSection,
        animalsSection,
        plantsSection,
    ]
    
    static let gamesSection = [
        Section("torgai"),
    ]
    
    static var songs = [
        Section("Koshakanym"),
    ]
    
    static var stories = [
        StorySection("kolobok"),
    ]
    
    private static var colorsSection = EduSection(name: "colorsIcon", scenesNames: [""], timepoints: [0], contentNames: ["red"])
        private static var shapesSection = EduSection(name: "shapesIcon", scenesNames: [""], timepoints: [0], contentNames: ["circle"])
    private static var animalsSection = EduSection(name: "animalsIcon", scenesNames: [""], timepoints: [0], contentNames: ["cat", "dog", "bear"])
    private static var plantsSection = EduSection(name: "plantsIcon", scenesNames: [""], timepoints: [0], contentNames: ["rose"])
}
