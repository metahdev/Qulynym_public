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

struct EduSection: Equatable {
    var name: String
    var contentNames: [String]
    
    init(name: String, contentNames: [String]) {
        self.name = name
        self.contentNames = contentNames
    }
}

struct Song {
    var name: String
    var lyrics: [String]
    var timestops: [(Float, Float)]
}

struct Video {
    var title: String
    var image: Data
}

struct Beine {
    var title: String
    var id: String
    var thumbnailURL: String
}

struct Content {
    static let sections: [Menu: [String]] = [.main: menuSections, .games: gamesSection]
    
    static let menuSections = [
        "Beıneler",
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
        Song(name: "Qoshaqanym", lyrics: Content.qoshakanymLyrics, timestops: [(29.8, 32), (33, 36), (37, 39.6), (40.8, 43), (44, 47), (48, 50), (51.6, 54.8), (55, 57.6), (59, 61), (62.6, 65), (66, 69.5), (70, 72), (73.6, 76), (77, 80), (80.6, 83.6), (84, 87), (88, 90), (91.5, 94), (95, 98.5), (99, 101.3), (102.6, 105), (106, 108.6), (110, 113), (113.6, 115.8), (131.6, 134.2), (135.3, 138), (139, 142), (142.6, 145), (146.3, 148.8), (150, 152.2), (153.5, 156.7), (157.3, 159.6)]),
        Song(name: "Aigo'lek", lyrics: Content.aigolekLyrics, timestops: [(18 , 19),(20, 21), (22, 24), (25, 26), (27, 28), (29, 30), (31, 32), (33, 34), (35, 36), (37, 38), (39, 40), (41, 42), (43, 44), (45, 46), (47, 48), (49, 50), (51, 52), (53, 54), (55, 56), (57, 58), (59, 60), (61, 62), (63, 65), (66, 67), (68, 69), (70, 71), (72, 73), (74, 75), (76, 77), (78, 79), (80, 81), (82, 83)]),
        Song(name: "Sarjaılay'", lyrics: Content.sarjailayLyrics, timestops: [(18, 23), (24, 31), (32, 38), (39, 45), (46, 47), (48, 49), (50, 52), (53, 55), (56, 57), (58, 59), (60, 63), (64, 65), (66, 72), (73, 79), (80, 86), (87, 93), (94, 95), (96, 97), (98,  100), (101, 103), (104, 105), (106, 107), (108, 111), (112, 114), (146, 152), (153, 158), (160, 166), (167, 173), (174, 175), (176, 177), (178, 180), (181, 183), (184, 185), (186, 187), (188, 191), (192, 194), (195, 196), (197, 198), (199, 201), (202, 205), (206, 207), (208, 209), (210, 211), (212, 216)]),
        Song(name: "Ertegіler álemі", lyrics: Content.ertegilerAlemiLyrics, timestops: [(0, 0)]),
        Song(name: "Asyl áje", lyrics: Content.asylAzheLyrics, timestops: [(0, 0)]),
        Song(name: "Bіr bala", lyrics: Content.birBalaLyrics, timestops: [(0, 0)])
    ]
    
    /* Mentions:
      Tolag'ai - Шәкен Айманов атындағы "Қазақфильм" АҚ (Sha'ken Aımanov atyndaǵy "Qazaqfılm" AQ)
      G'ajap qus - Azia Animation
     */
    
    
    static var stories = [
        "Bauyrsaq Ertegi", "G'ajap qus", "Tolag'ai"
    ]
    
    static var infoForParents = setAttributedText(type: .infoForParents)
    static var credits = setAttributedText(type: .credits)
    
    private static var colorsSection = EduSection(name: "Tu'ster", contentNames: ["Qyzyl", "Qyzg'ylt-sary", "Sary", "Jasyl", "Ko'gildir", "Ko'k", "K'ulgin", "Qon'yr", "Qara", "Qyzg'ylt", "Aq", "Sur"])
        private static var shapesSection = EduSection(name: "Pishinder", contentNames: ["U'shburysh", "Sharshy", "Tikto'rtburysh", "Shen'ber", "Zhuldyz", "Sopaqsha", "Zhu'rek", "Romb"])
    private static var animalsSection = EduSection(name: "Zhanuarlar", contentNames: ["Mysyq", "It", "At", "Sıyr", "Esek", "Qoı", "Shoshqa", "Qoıan", "Qumyrsqa", "Ko'belek", "U'ki", "Bu'rkit", "Torg'ai", "Tıіn", "Aiy'", "Qasqyr", "Tu'lki", "Barys", "Arystan", "Pil"])
    private static var plantsSection = EduSection(name: "O'simdikter", contentNames: ["Qaıyn'", "Alma ag'ashy", "Terek", "Qarag'aı", "Almurt ag'ashy", "Shyrsha", "Sheten", "Emen", "Ko'kterek", "Órіk ag'ashy", "Tan'qy'raı", "Mu'kjıdek", "Ray'shan", "Kakty's", "Qon'yray'gu'l", "Shegіrgu'l", "Bo'rtegu'l", "Tu'ımedaq", "Qyzg'aldaq", "Baqbaq"])
    
    static var parentsInfoBody = """
    Qulynym - balalarg'a arnalg'an mobıldі alag'. Bul salada a'n aıty'g'a, oınay'g'a, aqparattyq beınelerdі qaray'g'a, oqy'g'a, ertegіlerdі tyn'dan'g'a ja'ne sy'ret saly'g'a bolady.

    Bіzdіn' bag'darlamamyz - balanyn' bіlіmі men damy'y u'shіn qay'іpsіz ortam. Qosymshanyn' barlyq mazmuny balanyn' ana tіlіn tez a'rі tıіmdі damyty'g'a bag'yt alyp qazaq tіlіnde usynylg'an.

    Bala qosymshany paıdalang'an kezde ata-ananyn' qatysy'y mіndettі emes, o'ıtkenі naqty ınteraktıvtі dızaın balag'a tu'sіnіktі.
    """
    
    static var creditsBody = """
    Qatysy'shylarg'a u'lken rahmet:

    Zhumabaev Baubek, Meiramuly Rauan - iOS baǵdarlamashylar
    Amangeldy Aruzhan, Dospolova Dana - dızaınerler
    Akhmetgali Daulet - uıymdastyry' ko'mekshіsі
    Imash Daulet, Yeldossova Aruzhan - day'yspen a'reket ety'
    
    Some icons are taken from the icons8.com and the flaticon.com

    Flappy Torǵaı is made thanks to the Raywenderlich.com course: "How to make a game like flappy bird".
    
    Ertegіler:

    Bay'yrsak' - Balapan telearnasy
    Tolag'ai - Sha'ken Aımanov atyndag'y "Qazaqfılm" AQ
    G'ajap qus - Azia Animation
    
    A'nder:

    Qoshakanym:
    Túpnusqa - halyq a'nі
    Án oryndaýshy - Aınel Sapargalı

    Aigolek:
    Túpnusqa - Roza Rymbaeva
    Án oryndaýshy - ARUKA MIX(Youtube arnasy)

    Sarjailay:
    Túpnusqa - Mýkagalı Makataev
    Án oryndaýshy - Altynaı Jorabaeva

    ErtegilerAlemi:
    Túpnusqa - Aıgerım Kalay'baeva
    Án oryndaýshy - Aıgerım Kalay'baeva
    
    AsylAzhe:
    Túpnusqa - Qaraqat
    Án oryndaýshy - Qaraqat
    
    BirBala:
    Túpnusqa - Halyq a'nі
    Án oryndaýshy - Aı-Madı
    """
    
    private static var qoshakanymLyrics = ["Jazda apamnyń aýylyna,", "Baryp edіm qydyryp.", "Bіr qoshaqan aldymnan,", "Shug'a keldi júgіrіp.", "\nAq mańdaıy aı ma eken?!", "Sheker me eken, bal ma eken?!", "Kettіm ony saǵynyp,", "Qoshaqanym qaıda eken?!", "\nAq mańdaıy aı ma eken?!", "Sheker me eken, bal ma eken?!", "Kettіm ony saǵynyp,", "Qoshaqanym qaıda eken?!", "\nIzdedim men tau ishin,", "Shyg'a ma dep manyrap.", "Sag'yndym g'oi dauysyn,", "Sarg'aiganda zhapyraq.", "\nAq mańdaıy aı ma eken?!", "Sheker me eken, bal ma eken?!", "Kettіm ony saǵynyp,", "Qoshaqanym qaıda eken?!", "\nAq mańdaıy aı ma eken?!", "Sheker me eken, bal ma eken?!", "Kettіm ony saǵynyp,", "Qoshaqanym qaıda eken?!", "\nAq mańdaıy aı ma eken?!", "Sheker me eken, bal ma eken?!", "Kettіm ony saǵynyp,", "Qoshaqanym qaıda eken?!", "\nAq mańdaıy aı ma eken?!", "Sheker me eken, bal ma eken?!", "Kettіm ony saǵynyp,", "Qoshaqanym qaıda eken?!"]
    private static var aigolekLyrics = ["Kóldeı shalqyp jas ómіr,", "Tasyp jatqan shaǵynda", "Kemerіnen shalyqtap,", "Asyp shatqan shaǵynda", "\nOıyn oınap, án salmaı", "Óser bala bolar ma", "Kúmіs kúlkі kórmeı ol", "Kemelіne tolar ma.", "\nAıgólek aý aıgólek,", "Aıdyń júzі dóńgelek,", "Aıgólek dep án shyrqa", "El bóbegі kel, bóbek.", "\nAıgólek aý aıgólek,", "Aıdyń júzі dóńgelek,", "Aıgólek dep án shyrqa", "El bóbegі kel, bóbek.", "\nAsyl sózdіń ustasy-", "Aqyn bolar urpaqpyz", "Óner, bіlіm, eńbekke,", "Jaqyn bolar urpaqpyz", "\nOn saýsaǵy maıysqan", "Sheber bolar urpaqpyz,", "Tula boıy tolǵan bіr", "Óner bolar urpaqpyz.", "\nAıgólek aý aıgólek,", "Aıdyń júzі dóńgelek,", "Aıgólek dep án shyrqa", "El bóbegі kel, bóbek.", "\nAıgólek aý aıgólek,", "Aıdyń júzі dóńgelek,", "Aıgólek dep án shyrqa", "El bóbegі kel, bóbek."]
    private static var sarjailayLyrics = ["Jazıra, jasyl kіlem órnektegen", "Týǵan jerge, darıǵa, jer jetpegen, Sarjaılaýym", "Keń ólkem, áldıleı ber sen dep kelem", "Ańsap kelem, saǵynyp, shóldep kelem, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nArmysyń, ata-qonys, jasyl meken!", "Ulanyńmyn, men senіń qasyńda ótem, Sarjaılaýym", "Basqanyń jeruıyǵyn neǵylaıyn", "Jeruıyǵy ózіmnіń qasymda eken, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nJadyrap, jutaıynshy taý samalyn", "Osy edі ǵoı saǵynyp ańsaǵanym, Sarjaılaýym", "Gúlderіm, shyrshalarym, arshalarym", "Bárіńe arnap men búgіn án salamyn, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym", "\nSaýmal bulaq - baldaı dárіm", "Salqyn samal - baýraılaryń", "Saıalaǵan, beý, týǵan jer", "Saǵyndyrǵan, Sarjaılaýym"]
    private static var ertegilerAlemiLyrics = ["Ǵajaıyp tús kórdіm,", "Tań ata men búgіn.", "Ertegі álemnіń qyzyǵynda júrdіm.", "Nuryna shomyldym búgіn.", "Juldyz, aıy – kórkem,", "Ádemі edі netken!", "Qustary sóıleıdі,", "Bulttary terbeıdі,", "Men oıanyp kettіm, átteń!", "\nErtegіler, ertegіler,", "Nege menі ertpedіńder?!", "Álemderіńnіń ǵajap kúıіn", "Shertpedіńder, sender...", "\nErtegіler, ertegіler,", "Nege menі ertpedіńder?!", "Álemderіńnіń ǵajap kúıіn", "Shertpedіńder, sender...", "\nGúlderden, bulttardan,", "Ár gúlde bіr arman.", "Taýsylmaıtyn táttі,", "Syı ákelіp jatty", "Jan bіtkennіń bárі maǵan.", "\nErtegіler, ertegіler,", "Nege menі ertpedіńder?!", "Álemderіńnіń ǵajap kúıіn", "Shertpedіńder, sender...", "\nGúlderden, bulttardan,", "Ár gúlde bіr arman.", "Taýsylmaıtyn táttі,", "Syı ákelіp jatty", "Jan bіtkennіń bárі maǵan.", "\nErtegіler, ertegіler,", "Nege menі ertpedіńder?!", "Álemderіńnіń ǵajap kúıіn", "Shertpedіńder, sender...", "\nErtegіler, ertegіler,", "Nege menі ertpedіńder?!", "Álemderіńnіń ǵajap kúıіn", "Shertpedіńder, sender...", "\nErtegіler, ertegіler"]
    private static var asylAzheLyrics = ["Asyl ájem, ǵasyr ájem, ańsaǵan", "Saǵynyshym sary ormandaı samsaǵan,", "Áke bolyp júrgenіmdі umytyp", "Álі kúnge erkeleımіn men saǵan.", "\nQulyndaımyn asyr salǵan ańǵarda,", "Qozyńdaımyn oınaqtaǵan albarda.", "Ózіń barda qysylmaımyn kúlýden,", "Jylaýǵa da qysylmaımyn sen barda.", "Ózіń barda qysylmaımyn kúlýden,", "Jylaýǵa da qysylmaımyn sen barda.", "\nMen ózіńnen qabyldappyn súıýdі,", "Men ózіńnen qabyldappyn kúıýdі", "Senіń janyń júregіmde oraýly,", "Menіń janym jaýlyǵyńa túıýlі."]
    private static var birBalaLyrics = ["Taldan taıaq jas bala taıanbaıdy", "Bala búrkіt túlkіden aıanbaıdy", "\nÝgaı-aı", "Án salshy", "Bіr bala", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "\nEldіń kórkі, aq toty bіr balasyń", "Kózі qıyp qaı dushpan jamandaıdy", "\nÝgaı-aı", "Án salshy", "Bіr bala", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "\nQos etek burań bel", "Qýalaı soǵar qońyr jel", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "Qýalaı soǵar qońyr jel"]
}

func setAttributedText(type: TextType) -> NSAttributedString {
    let attributedText = (NSAttributedString(string: type == .credits ? Content.creditsBody : Content.parentsInfoBody, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 32)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
    
    return attributedText
}
