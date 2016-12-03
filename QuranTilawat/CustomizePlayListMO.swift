//
//  CustomizePlayList.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 11/6/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit
import CoreData

class CustomizePlayListMO: NSManagedObject {
}

extension CustomizePlayListMO {
    @NSManaged var playlistname: String
    @NSManaged var id: NSNumber
}
