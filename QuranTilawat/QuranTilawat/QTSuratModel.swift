//
//  QTSuratModel.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 9/10/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import Foundation

class QTSuratModel: QTModel {
    
    let suratName: String?
    let suratIndex: Int?
    let suratID: String?
    let ayatList: [QTAyatModel]?
    
    init(suratIndex: Int?, name: String?, iD: String?, list: [QTAyatModel]?) {
        suratName = name
        suratID = iD
        ayatList = list
        self.suratIndex = suratIndex
    }
}
