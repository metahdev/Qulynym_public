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
        Song(name: "Aigo'lek", lyrics: Content.aigolekLyrics, timestops: [(18.8, 20.6),(20.8, 22.6), (22.9, 24.8), (25, 26.6), (27, 28.8), (29, 30.7), (31, 33), (33.2, 34.9), (35.2, 37), (37.3, 39), (39.3, 41), (41.3, 43.2), (43.3, 45.3), (45.5, 47.2), (47.5, 49.3), (49.5, 51.2), (51.5, 53.3), (53.6, 55.3), (55.6, 57.3), (57.6, 59.4), (59.7, 61.5), (61.8, 63.5), (63.9, 65.6), (66, 67.6), (68, 69.9), (70, 71.8), (72, 73.9), (74, 75.9), (76.1, 78), (78.2, 80), (80.3, 82), (82.3, 84)]),
        Song(name: "Sarjaılay'", lyrics: Content.sarjailayLyrics, timestops: [(18, 23.8), (24, 31.8), (32, 38.8), (39, 45.8), (46, 47.8), (48, 49.8), (50, 52.8), (53, 55.8), (56, 57.8), (58, 59.8), (60, 63.8), (64, 65.8), (66, 72.8), (73, 79.8), (80, 86.8), (87, 93.8), (94, 95.8), (96, 97.8), (98,  100.8), (101, 103.8), (104, 105.8), (106, 107.8), (108, 111.8), (112, 114), (146, 152.8), (153, 158), (160, 166.8), (167, 173.8), (174, 175.8), (176, 177.8), (178, 180.8), (181, 183.8), (184, 185.8), (186, 187.8), (188, 191.8), (192, 194.8), (195, 196.8), (197, 198.8), (199, 201.8), (202, 205.8), (206, 207.8), (208, 209.8), (210, 211.8), (212, 216)]),
        Song(name: "Ertegіler álemі", lyrics: Content.ertegilerAlemiLyrics, timestops: [(17, 19.3), (20.8, 23.3), (24.2, 27.7), (28, 30.8), (32.2, 34.6), (36.2, 38.6), (39.5, 41.2), (41.3, 43), (43.3, 46.2), (47.2, 50.8), (51, 54.6), (55, 58.5), (58.7, 61.6), (62.5, 66.2), (66.4, 70), (70.2, 73.8), (74, 77), (82.2, 85), (86.1, 88.5), (89.5, 91), (91.4, 93), (93.2, 96.2), (97.2, 100.6), (101, 104.5), (104.9, 108.5), (108.6, 111.5), (176.5, 178.8), (180, 182.6), (183.6, 185.3), (185.5, 187), (187.4, 190.3), (191.3, 194.9), (195.1, 198.6), (199, 202.6), (202.8, 205.6), (206.6, 210.2), (210.5, 214), (214.3, 217.9), (218.2, 220.9), (222, 229.5)]),
        Song(name: "Asyl áje", lyrics: Content.asylAzheLyrics, timestops: [(13.7, 20.8), (21, 28.3), (28.5, 35.3), (35.8, 43.5), (59, 66), (66.3, 73.5), (73.7, 80.6), (81, 88), (88.4, 96.3), (96.8, 104.3), (124, 131.3), (131.6, 139.8), (140, 147), (147.4, 154.5), (154.6, 162.4), (163.2, 170.2), (170.5, 189.3)]),
        Song(name: "Bіr bala", lyrics: Content.birBalaLyrics, timestops: [(31.8, 45.5), (45.9, 56.3), (56.6, 59.5), (60, 63.2), (63.5, 66.6), (67, 74), (74.2, 80.8), (81.2, 88), (88.3, 95.4), (107.6, 121.4), (121.9, 132), (132.4, 135.5), (136, 139), (139.5, 142.6), (143, 149.9), (150, 156.8), (157, 164), (164.2, 170.9), (199.5, 206.3), (206.5, 213.2), (213.5, 220.3), (220.6, 227.5), (227.7, 135.3)])
    ]
    
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

    Askar Almukhamet, Zhumabaev Baubek - iOS baǵdarlamashylar
    Amangeldy Aruzhan, Dospolova Dana, Akhmetgali Daulet - dızaınerler
    Imash Daulet, Yeldossova Aruzhan - day'yspen a'reket ety'
    
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
    private static var asylAzheLyrics = ["Asyl ájem, ǵasyr ájem, ańsaǵan", "Saǵynyshym sary ormandaı samsaǵan,", "Áke bolyp júrgenіmdі umytyp", "Álі kúnge erkeleımіn men saǵan.", "\nQulyndaımyn asyr salǵan ańǵarda,", "Qozyńdaımyn oınaqtaǵan albarda.", "Ózіń barda qysylmaımyn kúlýden,", "Jylaýǵa da qysylmaımyn sen barda.", "Ózіń barda qysylmaımyn kúlýden,", "Jylaýǵa da qysylmaımyn sen barda.", "\nMen ózіńnen qabyldappyn súıýdі,", "Men ózіńnen qabyldappyn kúıýdі", "Senіń janyń júregіmde oraýly,", "Menіń janym jaýlyǵyńa túıýlі.", "\nSenіń janyń júregіmde oraýly,", "Menіń janym jaýlyǵyńa túıýlі.", "Menіń janym jaýlyǵyńa..."]
    private static var birBalaLyrics = ["Taldan taıaq jas bala taıanbaıdy", "Bala búrkіt túlkіden aıanbaıdy", "\nÝgaı-aı", "Án salshy", "Bіr bala", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "\nEldіń kórkі, aq toty bіr balasyń", "Kózі qıyp qaı dushpan jamandaıdy", "\nÝgaı-aı", "Án salshy", "Bіr bala", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "\nQos etek burań bel", "Qýalaı soǵar qońyr jel", "Qos etek burań bel", "Qýalaı soǵar qońyr jel", "Qýalaı soǵar qońyr jel"]
}

func setAttributedText(type: TextType) -> NSAttributedString {
    let attributedText = (NSAttributedString(string: type == .credits ? Content.creditsBody : Content.parentsInfoBody, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 32)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
    
    return attributedText
}
