/*
 * Qulynym
 * ItemContentService.swift
 *
 * Created by: Metah on 2/24/19
 *
 * Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

enum TextType {
    case infoForParents
    case credits
}

struct EduSection {
    var name: String
    var timepoints: [Int]
    var contentNames: [String]
    
    init(name: String, timepoints: [Int], contentNames: [String]) {
        self.name = name
        self.timepoints = timepoints
        self.contentNames = contentNames
    }
}

struct Song {
    var name: String
    var lyrics: String
    var forwardTextViewTimepoints: [Int: Int]
    var rewindTextViewTimepoints: [Int: Int]
}

struct ContentService {
    static let menuSections = [
        "Oqu",
        "O'len aitu",
        "Ertegilerdi tyndau",
        "Su'ret salu",
        "Oyin Oinau"
    ]
    
    static let toddlerSections = [
        colorsSection,
        shapesSection,
        animalsSection,
        plantsSection,
    ]
    
    static let gamesSection = [
        "Flappy Torg'ai",
    ]
    
    static var songs: [Song] = [
        Song(name: "Qoshaqanym", lyrics: ContentService.qoshakanymLyrics, forwardTextViewTimepoints: [44: 173, 58: 268, 73: 373, 87: 458, 130: 553, 155: 717], rewindTextViewTimepoints: [43: 0, 55: 173, 76: 268, 86: 337, 129: 432, 154: 526]),
        Song(name: "Aigo'lek", lyrics: ContentService.aigolekLyrics, forwardTextViewTimepoints: [26: 0, 34: 0, 42: 0, 51: 0, 59: 0, 67: 0, 75: 0, 84: 0], rewindTextViewTimepoints: [25: 0, 33: 0, 41: 0, 50: 0, 58: 0, 66: 0, 74: 0])
    ]
    
    static var stories = [
        "Bauyrsaq Ertegi",
    ]
    
    static var infoForParents = setAttributedText(type: .infoForParents)
    static var credits = setAttributedText(type: .credits)
    
    private static var colorsSection = EduSection(name: "Tu'ster", timepoints: [0], contentNames: ["Qyzyl", "Qyzg'ylt-sary", "Sary", "Jasyl", "Ko'gildir", "Ko'k", "K'ulgin", "Qon'yr", "Qara", "Aq"])
        private static var shapesSection = EduSection(name: "Pishinder", timepoints: [0], contentNames: ["U'shburysh", "Sharshy", "Tikto'rtburysh", "Shen'ber", "Zhuldyz", "Sopaqsha", "Zhu'rek", "Romb"])
    private static var animalsSection = EduSection(name: "Zhanuarlar", timepoints: [5], contentNames: ["Mysyq", "Bu'rkіt", "It", "At", "Esek", "Sıyr", "Qoı", "Shoshqa", "Qoıan", "Qumyrsqa", "Ko'belek", "U'ki", "Torg'ai", "Tıіn", "Aiy'", "Qasqyr", "Tu'lki", "Barys", "Arystan", "Pil"])
    private static var plantsSection = EduSection(name: "O'simdikter", timepoints: [0], contentNames: ["Qaıyn'", "Alma ag'ashy", "Terek", "Qarag'aı", "Almurt aǵashy", "Shyrsha", "Sheten", "Emen", "Ko'kterek", "Órіk ag'ashy", "Tan'qy'raı", "Mu'kjıdek", "Ray'shan", "Kakty's", "Qon'yray'gu'l", "Shegіrgu'l", "Bo'rtegu'l", "Tu'ımedaq", "Qyzg'aldaq", "Baqbaq"])
    
    static var parentsInfoBody = "Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents."
    
    static var creditsBody = "Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com."
    
    private static var qoshakanymLyrics = "Jazda apamnyń aýylyna,\nBaryp edіm qydyryp.\nBіr qoshaqan aldymnan,\n Shug'a keldi júgіrіp.\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nIzdedim men tau ishin,\nShyg'a ma dep manyrap.\nSag'yndym g'oi dauysyn,\nSarg'aiganda zhapyraq.\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!"
    private static var aigolekLyrics = "Kóldeı shalqyp jas ómіr,\nTasyp jatqan shaǵynda\nKemerіnen shalyqtap,\nAsyp shatqan shaǵynda\n\nOıyn oınap, án salmaı\nÓser bala bolar ma\nKúmіs kúlkі kórmeı ol\nKemelіne tolar ma.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek.\n\nAsyl sózdіń ustasy-\nAqyn bolar urpaqpyz\nÓner, bіlіm, eńbekke,\nJaqyn bolar urpaqpyz\n\nOn saýsaǵy maıysqan\nSheber bolar urpaqpyz,\nTula boıy tolǵan bіr\nÓner bolar urpaqpyz.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek."
}

func setAttributedText(type: TextType) -> NSAttributedString {
    let attributedText = (NSAttributedString(string: type == .credits ? ContentService.creditsBody : ContentService.parentsInfoBody, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 32)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
    
    return attributedText
}
