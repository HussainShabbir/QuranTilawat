//
//  CustomizeSuratMO.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 11/6/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit
import CoreData

class CustomizeSuratMO: NSManagedObject {
    
}

extension CustomizeSuratMO {
    @NSManaged var surat: String
    @NSManaged var startayat: String
    @NSManaged var endayat: String
    @NSManaged var  id: NSNumber
}
