//
//  PlayerViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/31/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class PlayerViewController: ViewController, AudioPlayerImageDelegating {
    var ayatIndex = 0
    var suratIndex = 0
    let audioPlayer = AudioPlayer.sharedInstance
    var customPlayList: [AnyObject]?
    var isCustomPlayList = false
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempoViewWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var tempoButtonAlignLeadingConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        audioPlayer.delegate = self
        audioPlayer.isCustomPlayList = isCustomPlayList
        audioPlayer.customPlayList = customPlayList
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        tempoViewWidthConstraint?.constant = 0
        tempoButtonAlignLeadingConstraint?.constant = 0
        containerView.isHidden = true
        if isCustomPlayList {
            titleLabel.text = "My PlayList"
        } else {
            titleLabel.text = modelController?.suratModelList?[suratIndex].suratName
        }
        // Do any additional setup after loading the view.
    }
    
    
    func initiatePlay() {
        audioPlayer.modelController = modelController
        audioPlayer.playStartingAyat()
    }
    
    
    func updateImage() {
        var image: UIImage?
        if !audioPlayer.isBismillah {
            image = UIImage(named: audioPlayer.imageName)
            audioPlayer.isBismillah = true
        }
        else{
            if isCustomPlayList{
                image = UIImage(named: audioPlayer.imageName)
            }
            else {
                image = UIImage(named: audioPlayer.imageName)
            }
        }
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func hideShowTempoView(sender: UIButton) {
        if tempoViewWidthConstraint?.constant == 0 {
           tempoViewWidthConstraint?.constant = 258
            tempoButtonAlignLeadingConstraint?.constant = 259
            containerView.isHidden = false
        } else {
            tempoViewWidthConstraint?.constant = 0
            tempoButtonAlignLeadingConstraint?.constant = 0
            containerView.isHidden = true
        }
    }
    
    
    @IBAction func tempEffect(sender: UIButton) {
        if let value = sender.currentTitle {
            let array = value.components(separatedBy: "X")
            if let tempoValue = array.first {
                audioPlayer.rate = Int(tempoValue)!
            }
        }
    }
    
    @IBAction func execute(sender: UIBarButtonItem?) {
        audioPlayer.bismillah = false
        if let tag = sender?.tag {
            switch tag {
            case 0:
                if var timeInterVal = audioPlayer.player?.currentTime {
                    timeInterVal = timeInterVal - 1
                    audioPlayer.player?.currentTime = timeInterVal
                }
                print("")
            case 1:
                audioPlayer.stopPlaying()
                imageView?.image = UIImage(named: "")
                print("")
            case 2:
                if !audioPlayer.playBackStateIsPaused {
                    audioPlayer.ayatIndex = ayatIndex
                    audioPlayer.suratIndex = suratIndex
                    audioPlayer.isBismillah = false
                }
                initiatePlay()
                print("")
            case 3:
                audioPlayer.player?.pause()
                audioPlayer.playBackStateIsPaused = true
                print("")
            case 4:
                if var timeInterVal = audioPlayer.player?.currentTime {
                    timeInterVal = timeInterVal + 1
                    audioPlayer.player?.currentTime = timeInterVal
                }
                print("")
            default:
                print("")
            }
        } else {
            
        }
    }
    

}
