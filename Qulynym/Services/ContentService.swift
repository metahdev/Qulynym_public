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
    var contentNames: [String]
    
    init(name: String, contentNames: [String]) {
        self.name = name
        self.contentNames = contentNames
    }
}

struct Song {
    var name: String
    var lyrics: String
}

struct Video {
    var title: String
    var image: Data
}

struct ContentService {
    static let menuSections = [
//        "Beıneler",
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
        Song(name: "Qoshaqanym", lyrics: ContentService.qoshakanymLyrics),
        Song(name: "Aigo'lek", lyrics: ContentService.aigolekLyrics),
        Song(name: "Sarjaılay'", lyrics: ContentService.sarjailayLyrics),
        Song(name: "Ertegіler álemі", lyrics: ContentService.ertegilerAlemiLyrics),
        Song(name: "Asyl áje", lyrics: ContentService.asylAzheLyrics),
        Song(name: "Bіr bala", lyrics: ContentService.birBalaLyrics)
    ]
    
    static var stories = [
        "Bauyrsaq Ertegi",
    ]
    
    static var infoForParents = setAttributedText(type: .infoForParents)
    static var credits = setAttributedText(type: .credits)
    
    private static var colorsSection = EduSection(name: "Tu'ster", contentNames: ["Qyzyl", "Qyzg'ylt-sary", "Sary", "Jasyl", "Ko'gildir", "Ko'k", "K'ulgin", "Qon'yr", "Qara", "Qyzg'ylt", "Aq", "Sur"])
        private static var shapesSection = EduSection(name: "Pishinder", contentNames: ["U'shburysh", "Sharshy", "Tikto'rtburysh", "Shen'ber", "Zhuldyz", "Sopaqsha", "Zhu'rek", "Romb"])
    private static var animalsSection = EduSection(name: "Zhanuarlar", contentNames: ["Mysyq", "It", "At", "Sıyr", "Esek", "Qoı", "Shoshqa", "Qoıan", "Qumyrsqa", "Ko'belek", "U'ki", "Bu'rkit", "Torg'ai", "Tıіn", "Aiy'", "Qasqyr", "Tu'lki", "Barys", "Arystan", "Pil"])
    private static var plantsSection = EduSection(name: "O'simdikter", contentNames: ["Qaıyn'", "Alma ag'ashy", "Terek", "Qarag'aı", "Almurt aǵashy", "Shyrsha", "Sheten", "Emen", "Ko'kterek", "Órіk ag'ashy", "Tan'qy'raı", "Mu'kjıdek", "Ray'shan", "Kakty's", "Qon'yray'gu'l", "Shegіrgu'l", "Bo'rtegu'l", "Tu'ımedaq", "Qyzg'aldaq", "Baqbaq"])
    
    static var parentsInfoBody = ""
    
    static var creditsBody = ""
    
    private static var qoshakanymLyrics = "Jazda apamnyń aýylyna,\nBaryp edіm qydyryp.\nBіr qoshaqan aldymnan,\n Shug'a keldi júgіrіp.\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nIzdedim men tau ishin,\nShyg'a ma dep manyrap.\nSag'yndym g'oi dauysyn,\nSarg'aiganda zhapyraq.\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!\n\nAq mańdaıy aı ma eken?!\nSheker me eken, bal ma eken?!\nKettіm ony saǵynyp,\nQoshaqanym qaıda eken?!"
    private static var aigolekLyrics = "Kóldeı shalqyp jas ómіr,\nTasyp jatqan shaǵynda\nKemerіnen shalyqtap,\nAsyp shatqan shaǵynda\n\nOıyn oınap, án salmaı\nÓser bala bolar ma\nKúmіs kúlkі kórmeı ol\nKemelіne tolar ma.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek.\n\nAsyl sózdіń ustasy-\nAqyn bolar urpaqpyz\nÓner, bіlіm, eńbekke,\nJaqyn bolar urpaqpyz\n\nOn saýsaǵy maıysqan\nSheber bolar urpaqpyz,\nTula boıy tolǵan bіr\nÓner bolar urpaqpyz.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek.\n\nAıgólek aý aıgólek,\nAıdyń júzі dóńgelek,\nAıgólek dep án shyrqa\nEl bóbegі kel, bóbek."
    private static var sarjailayLyrics = "Jazıra, jasyl kіlem órnektegen\nTýǵan jerge, darıǵa, jer jetpegen, Sarjaılaýym\nKeń ólkem, áldıleı ber sen dep kelem\nAńsap kelem, saǵynyp, shóldep kelem, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nArmysyń, ata-qonys, jasyl meken!\nUlanyńmyn, men senіń qasyńda ótem, Sarjaılaýym\nBasqanyń jeruıyǵyn neǵylaıyn\nJeruıyǵy ózіmnіń qasymda eken, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nJadyrap, jutaıynshy taý samalyn\nOsy edі ǵoı saǵynyp ańsaǵanym, Sarjaılaýym\nGúlderіm, shyrshalarym, arshalarym\nBárіńe arnap men búgіn án salamyn, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym\n\nSaýmal bulaq - baldaı dárіm\nSalqyn samal - baýraılaryń\nSaıalaǵan, beý, týǵan jer\nSaǵyndyrǵan, Sarjaılaýym"
    private static var ertegilerAlemiLyrics = "Ǵajaıyp tús kórdіm,\nTań ata men búgіn.\nErtegі álemnіń qyzyǵynda júrdіm.\nNuryna shomyldym búgіn.\nJuldyz, aıy – kórkem,\nÁdemі edі netken!\nQustary sóıleıdі,\nBulttary terbeıdі,\nMen oıanyp kettіm, átteń!\n\nErtegіler, ertegіler,\nNege menі ertpedіńder?!\nÁlemderіńnіń ǵajap kúıіn\nShertpedіńder, sender...\n\nErtegіler, ertegіler,\nNege menі ertpedіńder?!\nÁlemderіńnіń ǵajap kúıіn\nShertpedіńder, sender...\n\nGúlderden, bulttardan,\nÁr gúlde bіr arman.\nTaýsylmaıtyn táttі,\nSyı ákelіp jatty\nJan bіtkennіń bárі maǵan.\n\nErtegіler, ertegіler,\nNege menі ertpedіńder?!\nÁlemderіńnіń ǵajap kúıіn\nShertpedіńder, sender...\n\nGúlderden, bulttardan,\nÁr gúlde bіr arman.\nTaýsylmaıtyn táttі,\nSyı ákelіp jatty\nJan bіtkennіń bárі maǵan.\n\nErtegіler, ertegіler,\nNege menі ertpedіńder?!\nÁlemderіńnіń ǵajap kúıіn\nShertpedіńder, sender...\n\nErtegіler, ertegіler,\nNege menі ertpedіńder?!\nÁlemderіńnіń ǵajap kúıіn\nShertpedіńder, sender...\n\nErtegіler, ertegіler"
    private static var asylAzheLyrics = "Asyl ájem, ǵasyr ájem, ańsaǵan\nSaǵynyshym sary ormandaı samsaǵan,\nÁke bolyp júrgenіmdі umytyp\nÁlі kúnge erkeleımіn men saǵan.\n\nQulyndaımyn asyr salǵan ańǵarda,\nQozyńdaımyn oınaqtaǵan albarda.\nÓzіń barda qysylmaımyn kúlýden,\nJylaýǵa da qysylmaımyn sen barda.\nÓzіń barda qysylmaımyn kúlýden,\nJylaýǵa da qysylmaımyn sen barda.\n\nMen ózіńnen qabyldappyn súıýdі,\nMen ózіńnen qabyldappyn kúıýdі\nSenіń janyń júregіmde oraýly,\nMenіń janym jaýlyǵyńa túıýlі."
    private static var birBalaLyrics = "Taldan taıaq jas bala taıanbaıdy\nBala búrkіt túlkіden aıanbaıdy\n\nÝgaı-aı\nÁn salshy\nBіr bala\nQos etek burań bel\nQýalaı soǵar qońyr jel\nQos etek burań bel\nQýalaı soǵar qońyr jel\n\nEldіń kórkі, aq toty bіr balasyń\nKózі qıyp qaı dushpan jamandaıdy\n\nÝgaı-aı\nÁn salshy\nBіr bala\nQos etek burań bel\nQýalaı soǵar qońyr jel\nQos etek burań bel\nQýalaı soǵar qońyr jel\n\nQos etek burań bel\nQýalaı soǵar qońyr jel\nQos etek burań bel\nQýalaı soǵar qońyr jel\nQýalaı soǵar qońyr jel"
    
}

func setAttributedText(type: TextType) -> NSAttributedString {
    let attributedText = (NSAttributedString(string: type == .credits ? ContentService.creditsBody : ContentService.parentsInfoBody, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 32)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
    
    return attributedText
}
