//
//  QTAyatModel.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 9/10/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import Foundation
import CoreData

class QTAyatModel {
    var ayatName: String?
    var ayatNameExt: String?
    var aayatFilePath: String?
    var startAyat: Int?
    var endAyat: Int?
    
    init(name: String?,ext: String?,path: String?, startAyat: Int?, endAyat: Int?) {
        ayatName = name
        ayatNameExt = ext
        aayatFilePath = path
        self.startAyat = startAyat
        self.endAyat = endAyat
    }
}
