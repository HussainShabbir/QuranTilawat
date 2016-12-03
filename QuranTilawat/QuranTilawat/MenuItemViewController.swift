//
//  MenuItemViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/22/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit
import MessageUI
enum menuItems: Int {
    case home = 0
    case playList
    case feedback
    case rateUs
    case version
    case help
}


class MenuItemViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UIViewControllerTransitioningDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let animatedVC = PresentingAnimatedController()
    let animatedDismissVC = DismissAnimatedController()
    var sidemenuList = ["Home","My Playlist","Feedback","Rate us","Version 1.0","Help"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.backgroundView = UIImageView(image: UIImage(named: "quran2"))
        
        delay(0.0) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView(strongSelf.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        }
        // Do any additional setup after loading the view.
    }

    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sidemenuList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") {
            tableCell.textLabel?.text = sidemenuList[indexPath.row]
            tableCell.textLabel?.textColor = UIColor.white
            cell = tableCell
        }else{
            cell = UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let menuItems = menuItems(rawValue: indexPath.row) {
            switch menuItems {
            case .home:
                performSegue(withIdentifier: "NavigationView", sender: nil)
            case .playList:
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyBoard.instantiateViewController(withIdentifier: "MyPlayListView") as? MyPlayListViewController
                self.present(controller!, animated: true, completion: nil)
                print("playList")
            case .feedback:
                print("feedback")
                let mailComposeViewController = MFMailComposeViewController()
                mailComposeViewController.mailComposeDelegate = self
                mailComposeViewController.setToRecipients(["er.hussain52@gmail.com"])
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    showSendMailErrorAlert()
                }

            case .rateUs:
                
                UIApplication.shared.open(URL(string: "itms-apps://itunes.apple.com/app/id1182749056")!, options: [:], completionHandler: nil)
                print("rateUs")
            case .version:
                print("version")
            case .help:
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyBoard.instantiateViewController(withIdentifier: "pageView") as? PageViewController
                self.present(controller!, animated: true, completion: nil)
                print("help")

            }
        }
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        sendMailErrorAlertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainMenuVC = segue.destination as? UINavigationController {
            mainMenuVC.transitioningDelegate = self
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatedVC
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatedDismissVC
    }
    
}
