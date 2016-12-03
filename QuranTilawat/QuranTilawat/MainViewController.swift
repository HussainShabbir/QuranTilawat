//
//  ViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/22/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit

class MainViewController: ViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var tableDataSourceList = [Int: String]()
    var dict: [String: Int]?
    var tableDataSourceKeys: [Int]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDataSourceList = suratList
        updateKeys()
        tableView.reloadData()
        title = "Surat"
        tableView.backgroundView = UIImageView(image: UIImage(named: "quran2"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateKeys() {
        tableDataSourceKeys = []
        for key in tableDataSourceList.keys {
            tableDataSourceKeys?.append(key)
        }
        tableDataSourceKeys?.sort()
    }
    @IBAction func dismiss(sender: AnyObject?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doShare(sender: AnyObject?) {
        let textToShare = "Hey! I just downloaded the app, Its amazing quiz app for creating playlist file and playing ayat inside Quran. Here is the link if you want to download."
        let link = "https://itunes.apple.com/us/app/qurantilawat/id1182749056?ls=1&mt=8"
        let objectsToShare = [textToShare, link]

        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.addToReadingList,UIActivityType.copyToPasteboard,UIActivityType.postToFlickr,UIActivityType.postToWeibo,UIActivityType.assignToContact,UIActivityType.postToVimeo,UIActivityType.postToTencentWeibo,UIActivityType.print,UIActivityType.saveToCameraRoll,UIActivityType.airDrop]
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad){
            activityVC.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func doSearch(sender: AnyObject?) {
        tableView.setContentOffset(CGPoint.zero, animated: true)
        delay(miliseconds: 500) {[weak self] in
            self?.searchBar.becomeFirstResponder()
        }
    }
    
    /*@IBAction func doAdd(sender: AnyObject?) {
        performSegue(withIdentifier: "addPlayList", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddPlayListViewController {
         vc.modelController
        }
    }*/
    
    func delay(miliseconds: Int, closure: @escaping() -> Void) {
        let deadline = DispatchTime.now() + .milliseconds(miliseconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            closure()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count >= 2 {
            //Filtering an array
            //tableDataSourceList = suratList.map {key,value in value}.filter {($0.contains(searchText))}
            
            //Filtering an dictionary
            let filtered = suratList.filter {($0.1.lowercased().contains(searchText.lowercased()))}
            var dataSourceList = [Int: String]()
            for result in filtered {
                dataSourceList[result.0] = result.1
            }
            tableDataSourceList = dataSourceList
            updateKeys()
            tableView.reloadData()
        } else if searchText.characters.count == 0 {
            tableDataSourceList = suratList
            updateKeys()
            tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: "resueIdentifier") {
            let suratNo = indexPath.row + 1
            if let key = tableDataSourceKeys, let surat = tableDataSourceList[key[indexPath.row]] {
                tableCell.textLabel?.text = "\(suratNo).  \(surat)"
                tableCell.textLabel?.textColor = UIColor.white
            }
            cell = tableCell
        }else{
            cell = UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard tableDataSourceList.keys.count > indexPath.row else { return }
        let suratKeyIndex = Array(tableDataSourceList.keys).sorted()[indexPath.row]
        dict = ["surat":suratKeyIndex,"ayat" : 0]
        performSegue(withIdentifier: "PlayerViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vw = segue.destination as? PlayerViewController{
            vw.modelController = modelController
            if let dict = dict {
                vw.suratIndex = dict["surat"]!
                vw.ayatIndex = dict["ayat"]!
            }
        }
    }
    
}

