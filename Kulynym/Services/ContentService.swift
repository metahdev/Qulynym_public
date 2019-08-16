/*
 * Kulynym
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
        "torgai",
    ]
    
    static var songs: [(String, String)] = [
        ("Qoshaqanym", ContentService.qoshakanymLyrics),
        ("Aigo'lek", ContentService.aigolekLyrics)
    ]
    
    static var stories = [
        "Bauyrsaq Ertegi",
    ]
    
    static var infoForParents = setAttributedText(type: .infoForParents)
    static var credits = setAttributedText(type: .credits)
    
    private static var colorsSection = EduSection(name: "colorsIcon", scenesNames: [""], timepoints: [0], contentNames: ["red"])
        private static var shapesSection = EduSection(name: "shapesIcon", scenesNames: [""], timepoints: [0], contentNames: ["circle"])
    private static var animalsSection = EduSection(name: "animalsIcon", scenesNames: ["Anim1", "Anim2"], timepoints: [5], contentNames: ["cat", "dog", "bear", "eagle", "elephant", "esek", "owl", "ant"])
    private static var plantsSection = EduSection(name: "plantsIcon", scenesNames: [""], timepoints: [0], contentNames: ["rose"])
    
    static var parentsInfoTitle = "          Info for parents"
    static var creditsTitle = "        Credits"
    
    static var parentsInfoBody = "\n \n Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. Information for parents. "
    
    static var creditsBody = "\n \n Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. Eraser icon made by PixelBuddha at the flaticon.com. "
    
    private static var qoshakanymLyrics =  "Jazda apamnyń aýylyna,\nBaryp edіm qydyryp.\nBіr qoshaqan aldymnan,\nOınap shyqty júgіrіp.\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nDemalysta ózіńdі,\nTaǵy іzdep baramyn.\nBіr qoshaqan bárі bіr,\nSenі taýyp alamyn.\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nQozylarym júr me eken?Erke sulý sol ma eken?!\nMenі qashan keler dep,\nSaǵynyp ol júr me eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!"
    private static var aigolekLyrics = "Kóldeı shalqyp jas ómіr,\nTasyp jatqan shaǵynda\nKemerіnen shalyqtap,\nAsyp shatqan shaǵynda\nOıyn oınap, án salmaı\nÓser bala bolar ma\nKúmіs kúlkі kórmeı ol\nKemelіne tolar ma.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıdaı tolǵan kezіmde 3 ret\nBı bıleımіn dóńgelep.\n\nAsyl sózdіń ustasy-\nAqyn bolar urpaqpyz\nÓner, bіlіm, eńbekke,\nJaqyn bolar urpaqpyz\nOn saýsaǵy maıysqan\nSheber bolar urpaqpyz,\nTula boıy tolǵan bіr\nÓner bolar urpaqpyz.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıdaı tolǵan kezіmde 3 ret\nBı bıleımіn dóńgelep."
}

func setAttributedText(type: TextType) -> NSAttributedString {
    let attributedText = NSMutableAttributedString(string: type == .credits ? ContentService.creditsTitle: ContentService.parentsInfoTitle, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 52)!])
    
    attributedText.append(NSAttributedString(string: type == .credits ? ContentService.creditsBody : ContentService.parentsInfoBody, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 32)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
    
    return attributedText
}
