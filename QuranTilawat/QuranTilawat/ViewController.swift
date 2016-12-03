//
//  ViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/29/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var modelController: QTSuratModelController?
    
    override func viewDidLoad() {
        modelController = QTSuratModelController()
        modelController?.updateModel()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
