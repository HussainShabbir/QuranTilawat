//
//  MyPlayListViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 11/6/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class MyPlayListViewController: ViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var playList: [AnyObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "quran2"))
        let userDefault = UserDefaults.standard
        if let list = userDefault.value(forKey: "playLists") as? [AnyObject]{
            playList = list
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if playList == nil || playList?.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "No data found", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {[weak self] (UIAlertAction) in
                self?.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: UIBarButtonItem?) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if let playListCount = playList?.count {
            count = playListCount
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "reuseIdentifier")
        cell.backgroundColor = UIColor.clear
        let surats = playList?[indexPath.row]
        cell.detailTextLabel?.text = surats?["playList"] as? String
        cell.detailTextLabel?.textColor = UIColor.white
        if let image = surats?["image"] {
            cell.imageView?.image = UIImage(data: image as! Data)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let audioPlayer = AudioPlayer.sharedInstance
        audioPlayer.playListIndex = indexPath.row
        performSegue(withIdentifier: "PlayerViewController", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let userDefault = UserDefaults.standard
            var isDelete = false
            if var playList = playList {
                if playList.count > indexPath.row {
                    playList.remove(at: indexPath.row)
                    userDefault.set(playList, forKey: "playLists")
                    userDefault.synchronize()
                    isDelete = true
                }
            }
            if isDelete {
                if let list = userDefault.value(forKey: "playLists") as? [AnyObject]{
                    playList = list
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vw = segue.destination as? PlayerViewController{
            vw.modelController = modelController
            vw.customPlayList = playList
            vw.isCustomPlayList = true
        }
    }
}
