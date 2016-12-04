//
//  QTSuratModelController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 9/10/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import Foundation
import UIKit

class QTSuratModelController: QTModelController {

    
    var isFirstAyatPlayed = false
    var shouldAdd = false
    var suratModelList: [QTSuratModel]?
//    var playList: [QTPlayListModel]? = []
    var suratImageIndex: Int? = 0
    var ayatImageIndex: Int? = 0
    
    var playListSurat: Int? = 0
    var maxAyat: Int? = 0
    var suratIndex: Int? = 0
    var startIndex: Int? = 0
    var endIndex: Int? = 0
    
    
    
    func updateModel() {
        let mainBundle = Bundle.main
        startingAyat = mainBundle.path(forResource: "001000", ofType: "mp3")
        bismillahAyat = mainBundle.path(forResource: "001001", ofType: "mp3")
        var i = 0,j = 0
        suratModelList = []
        var previousSurat = ""
        var ayatModel: [QTAyatModel] = []
            for mp3FileName in ayatMp3FileList {
                let ayatName = String(mp3FileName)
                let currentSurat = ayatName!.substring(to: 3)
                if let ayatPath = mainBundle.path(forResource: ayatName, ofType: "mp3") {
                    //var counter = 0
                    var imgNm: String = ""
                    
                    /*for character in ayatName!.characters {
                        counter = counter + 1
                        if character != "0" && counter <= 3 {
                            imgNm.append(character)
                            } else if counter == 4 {
                                imgNm.append("_")
                                if character != "0" {
                                    imgNm.append(character)
                                }
                            } else if character != "0" && counter > 4 {
                                imgNm.append(character)
                            }
                        }*/
                    
                    let imageName = Int(ayatName!)
                    let imageNameString = String(describing: imageName!)
                    var suratNo = ""
                    var ayatNo = ""
                    if imageNameString.characters.count == 4 {
                        print("Four")
                        suratNo = imageNameString.substring(to: 1)
                        let ayatNumber = imageNameString.substring(from: 2)
                        ayatNo = convertIntoString(value: Int(ayatNumber)!)
                    }
                    else if imageNameString.characters.count == 5 {
                        print("Five")
                        suratNo = imageNameString.substring(to: 2)
                        let ayatNumber = imageNameString.substring(from: 3)
                        ayatNo = convertIntoString(value: Int(ayatNumber)!)
                        
                    }
                    else if imageNameString.characters.count == 6 {
                        print("Six")
                        suratNo = imageNameString.substring(to: 3)
                        let ayatNumber = imageNameString.substring(from: 4)
                        ayatNo = convertIntoString(value: Int(ayatNumber)!)
                    }
                    imgNm = "\(suratNo)_\(ayatNo)"
                    
                    if previousSurat == currentSurat || i == 0 {
                        ayatModel.append(QTAyatModel(name: imgNm, ext: "mp3",path: ayatPath,startAyat: nil,endAyat: nil))
                        previousSurat = currentSurat
                        if j == 113 && ayatMp3FileList.last == mp3FileName {
                            suratModelList?.append(QTSuratModel(suratIndex: nil, name: suratList[j], iD: String(j), list: ayatModel))
                        }
                    } else {
                        suratModelList?.append(QTSuratModel(suratIndex: nil, name: suratList[j], iD: String(j), list: ayatModel))
                        ayatModel = []
                        ayatModel.append(QTAyatModel(name: imgNm, ext: "mp3",path: ayatPath,startAyat: nil,endAyat: nil))
                        j = j + 1
                        previousSurat = currentSurat
                        
                    }
                i = i + 1
            }
        }
    }
    
    func convertIntoString(value: Int) -> String{
        return String(value)
    }
    
}




extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}
