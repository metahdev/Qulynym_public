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
    var timestops: [(Int, Int)]
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

struct ContentService {
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
    
//    Song(name: "Qoshaqanym", lyrics: ContentService.qoshakanymLyrics, forwardTextViewTimepoints: [44: 173, 58: 268, 73: 373, 87: 458, 130: 553, 155: 717], rewindTextViewTimepoints: [43: 0, 55: 173, 76: 268, 86: 337, 129: 432, 154: 526]),
//           Song(name: "Aigo'lek", lyrics: ContentService.aigolekLyrics, forwardTextViewTimepoints: [26: 0, 34: 0, 42: 0, 51: 0, 59: 0, 67: 0, 75: 0, 84: 0], rewindTextViewTimepoints: [25: 0, 33: 0, 41: 0, 50: 0, 58: 0, 66: 0, 74: 0])
//
    static var songs: [Song] = [
        Song(name: "Qoshaqanym", lyrics: ContentService.qoshakanymLyrics, timestops: [(30, 32), (33, 35), (37, 39), (40, 43), (44, 46), (48, 50)]),
        Song(name: "Aigo'lek", lyrics: ContentService.aigolekLyrics, timestops: [(0, 0)]),
        Song(name: "Sarjaılay'", lyrics: ContentService.sarjailayLyrics, timestops: [(0, 0)]),
        Song(name: "Ertegіler álemі", lyrics: ContentService.ertegilerAlemiLyrics, timestops: [(0, 0)]),
        Song(name: "Asyl áje", lyrics: ContentService.asylAzheLyrics, timestops: [(0, 0)]),
        Song(name: "Bіr bala", lyrics: ContentService.birBalaLyrics, timestops: [(0, 0)])
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
    private static var plantsSection = EduSection(name: "O'simdikter", contentNames: ["Qaıyn'", "Alma ag'ashy", "Terek", "Qarag'aı", "Almurt aǵashy", "Shyrsha", "Sheten", "Emen", "Ko'kterek", "Órіk ag'ashy", "Tan'qy'raı", "Mu'kjıdek", "Ray'shan", "Kakty's", "Qon'yray'gu'l", "Shegіrgu'l", "Bo'rtegu'l", "Tu'ımedaq", "Qyzg'aldaq", "Baqbaq"])
    
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
    let attributedText = (NSAttributedString(string: type == .credits ? ContentService.creditsBody : ContentService.parentsInfoBody, attributes: [NSAttributedString.Key.font: UIFont(name: "Gill Sans", size: 32)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
    
    return attributedText
}
