//
//  AudioPlayer.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/23/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit
import AVFoundation
protocol AudioPlayerImageDelegating: class {
    func updateImage()
}
class AudioPlayer: NSObject,AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    var startAyat = false
    var bismillah = false
    
    var shouldShowPlayList = false
    var modelController: QTSuratModelController?
    var isStoppedPlaying = false
    var playCounter = 0
    var ayatCount = 0
    var playListSuratIndex = 0
    weak var delegate: AudioPlayerImageDelegating?
    var ayatIndex = 0
    var suratIndex = 0
    var playListIndex = 0
    
    var customizeStart = 0
    var customizeEnd = 0
    var customizeSurat = 0
    
    var imageName = ""
    
    var playBackStateIsPaused = false
    var isBismillah = false
    var isCustomPlayList = false
    var customPlayList : [AnyObject]?
    var rate = 1
    static let sharedInstance : AudioPlayer = {
        let instance = AudioPlayer()
        return instance
    }()
    
    
    func playSurat(path: String) {
        delegate?.updateImage()
        player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        player?.delegate = self
        player?.enableRate = true
        player?.rate = Float(rate)
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        player?.play()
    }
    
    
    func stopPlaying(){
        if let player = player {
            if player.isPlaying {
                player.stop()
                ayatIndex = 0
                suratIndex = 0
                playListIndex = 0
                customizeStart = 0
                customizeEnd = 0
                customizeSurat = 0
            }
        }
    }
    
    func playStartingAyat() {
        playBackStateIsPaused = false
        if let modelController = modelController {
            if !startAyat && !isCustomPlayList {
                if let startingAyat = modelController.startingAyat {
                    playSurat(path: startingAyat)
                    startAyat = true
                }
            } else if !bismillah{
                if let bismillahAyat = modelController.bismillahAyat {
                    imageName = "1_1"
                    playSurat(path: bismillahAyat)
                    bismillah = true
                }
            } else {
                if isCustomPlayList {
                    playRemainingAyatOfCustomizeSurat()
                } else {
                    playRemainingAyat()
                }
            }
        }
    }
    
    
    func playRemainingAyat() {
        if let ayatCount = modelController?.suratModelList?[suratIndex].ayatList?.count, ayatCount > 0 {
            print(ayatCount)
            if ayatCount > ayatIndex {
                if let ayatPath = modelController?.suratModelList?[suratIndex].ayatList?[ayatIndex].aayatFilePath {
                    print(ayatPath)
                    if let imageNm = modelController?.suratModelList?[suratIndex].ayatList?[ayatIndex].ayatName {
                        imageName = imageNm
                    }
                    playSurat(path: ayatPath)
                    ayatIndex = ayatIndex + 1
                }
            }
            else {
              stopPlaying()
            }
        }
    }
    
    func playRemainingAyatOfCustomizeSurat() {
        let surats = customPlayList?[playListIndex]
        if let surats = surats?["surats"] as? [AnyObject] {
            if surats.count > suratIndex {
            let list = surats[suratIndex]
            if let surat = list["surat"] as? String, let start = list["start"] as? String, let end = list["end"] as? String {
                if customizeStart == 0 {
                    customizeStart = Int(start)! - 1
                }
                customizeEnd = Int(end)!
                customizeSurat = Int(surat)! - 1
                if let ayatCount = modelController?.suratModelList?[customizeSurat].ayatList?.count, ayatCount > 0 {
                    if ayatCount >= customizeEnd && customizeStart < customizeEnd {
                        if let ayatPath = modelController?.suratModelList?[customizeSurat].ayatList?[customizeStart].aayatFilePath {
                            if let imageNm = modelController?.suratModelList?[customizeSurat].ayatList?[customizeStart].ayatName {
                                imageName = imageNm
                            }
                            playSurat(path: ayatPath)
                            customizeStart = customizeStart + 1
                        }
                    } else {
                        suratIndex = suratIndex + 1
                        customizeStart = 0
                        isBismillah = false
                        playRemainingAyatOfCustomizeSurat()
                    }
                }
            }
            
            } else {
                stopPlaying()
            }

        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if !bismillah{
            if let bismillahAyat = modelController?.bismillahAyat {
                imageName = "1_1"
                playSurat(path: bismillahAyat)
                bismillah = true
            }
        } else {
            if isCustomPlayList {
                playRemainingAyatOfCustomizeSurat()
            } else {
                playRemainingAyat()
            }
        }
    }
    

}
