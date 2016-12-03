//
//  PageContentViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/27/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    var pageIndex: Int?
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textVw: UITextView!
    
    let textVwDesc1 = "It contain total 114 surats. For playing the individual surats tap on the surats. It also has tempo effects. Basically you can apply the tempo effect before playing the surat. If apply in the middle of surat then effect will automatically apply on the next line of surat"
    let textVwDesc2 = "This app main purpose is to create the custom playlist. You can also add more customize surat on the same playlist and can also create multiple playlists. And in order to delete the existing playlist, just do the swipe right."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textVw.layer.cornerRadius = 5.0
        textVw.clipsToBounds = true
        if let pageIndex = pageIndex {
            pageControl.currentPage = pageIndex
            if pageIndex == 0 {
                textVw.text = textVwDesc1
            }else{
                textVw.text = textVwDesc2
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: UIBarButtonItem?) {
        dismiss(animated: true, completion: nil)
    }
}
