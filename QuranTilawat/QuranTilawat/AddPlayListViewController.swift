//
//  AddPlayListViewController.swift
//  QuranTilawat
//
//  Created by Hussain Shabbir on 10/23/16.
//  Copyright © 2016 Hussain Shabbir. All rights reserved.
//

import UIKit
import CoreData

class AddPlayListViewController: ViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    /*@IBOutlet weak var nameLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var fromSurateadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var startAyatleadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var endAyatleadingConstraint: NSLayoutConstraint!
    */
    
    /*@IBOutlet weak var playListNm: UITextField!
    @IBOutlet weak var surat: UITextField!
    */
    @IBOutlet weak var startAyat: UILabel!
    @IBOutlet weak var endAyat: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var suratBtn: UIButton!
    @IBOutlet weak var startAyatBtn: UIButton!
    @IBOutlet weak var endAyatBtn: UIButton!
    @IBOutlet weak var allAyatBtn: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerViewHeightConstraint: NSLayoutConstraint!
    var pickerDataSource: [AnyObject]?
    var isShow = false
    var toolbar: UIToolbar!
    var tagValue: Int = 0
    var playList: UITextField?
    var playLists: [AnyObject]?
    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBorderOnButton()
        enableDisableSaveButton()
        imagePicker = UIImagePickerController()
        imagePicker?.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        imagePicker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        let userDefault = UserDefaults.standard
        if let list = userDefault.value(forKey: "playLists") as? [AnyObject]{
            playLists = list
        }
        //saveData()
        //getData()
        // Do any additional setup after loading the view.
    }
    
    func enableDisableSaveButton() {
        if let _ = suratBtn.currentTitle, let _ = startAyatBtn.currentTitle , let _ = endAyatBtn.currentTitle {
            saveButton.isEnabled =  true
        } else if allAyatBtn.currentTitle! == "YES" {
            saveButton.isEnabled =  true
        }
        else {
            saveButton.isEnabled =  false
        }
    }
    
    func drawBorderOnButton() {
        
        let width: CGFloat = 1.0
        let borderColor = UIColor.black.cgColor
        let ayatBorderColor = UIColor.black.cgColor
        
        suratBtn.layer.borderWidth = width
        suratBtn.layer.borderColor = borderColor
        
        updateStartEndAyat(width: width, borderColor: ayatBorderColor, textColor: UIColor.lightGray)
        
        allAyatBtn.layer.borderWidth = width
        allAyatBtn.layer.borderColor = borderColor
    }
    
    func updateStartEndAyat(width: CGFloat, borderColor: CGColor, textColor: UIColor) {
        startAyatBtn.layer.borderWidth = width
        startAyatBtn.layer.borderColor = borderColor
        startAyat.textColor = textColor
        
        endAyatBtn.layer.borderWidth = width
        endAyatBtn.layer.borderColor = borderColor
        endAyat.textColor = textColor
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var pickerDataSourceCount = 0
        if let pickerDataSource = pickerDataSource {
            pickerDataSourceCount = pickerDataSource.count
        }
        return pickerDataSourceCount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var rowValue = ""
        if let pickerDataSource = pickerDataSource {
            rowValue = String(describing: pickerDataSource[row])
        }
        return rowValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerDataSource = pickerDataSource, pickerDataSource.count > 0 {
            switch tagValue {
            case 0:
                suratBtn.setTitle((String(describing: pickerDataSource[row])), for: UIControlState.normal)
                if allAyatBtn.currentTitle == "NO" {
                    startAyatBtn.titleLabel?.text = "1"
                    endAyatBtn.titleLabel?.text = "2"
                }
            case 1:
                startAyatBtn.setTitle((String(describing: pickerDataSource[row])), for: UIControlState.normal)
            case 2:
                endAyatBtn.setTitle((String(describing: pickerDataSource[row])), for: UIControlState.normal)
            default:
                allAyatBtn.setTitle((String(describing: pickerDataSource[row])), for: UIControlState.normal)
                if allAyatBtn.currentTitle == "NO" {
                    updateStartEndAyat(width: 1.0, borderColor: UIColor.black.cgColor, textColor: UIColor.white)
                    startAyatBtn.titleLabel?.textColor = UIColor.black
                    endAyatBtn.titleLabel?.textColor = UIColor.black
                } else {
                    updateStartEndAyat(width: 1.0, borderColor: UIColor.lightGray.cgColor, textColor: UIColor.lightGray)
                    startAyatBtn.titleLabel?.textColor = UIColor.lightGray
                    endAyatBtn.titleLabel?.textColor = UIColor.lightGray
                }
                print("Some Default")
            }
            enableDisableSaveButton()
        }
    }
    
    @IBAction func openPicker(sender: UIButton?) {
        pickerDataSource = []
            if let suratNo = suratBtn.currentTitle , suratNo.characters.count > 0 && sender?.tag == 0 || sender?.tag == 4 || allAyatBtn.currentTitle == "NO" {
                if let sender = sender {
                    tagValue = sender.tag
                }
                if sender?.tag == 0 {
                    for i in 1...114 {
                        pickerDataSource?.append(i as AnyObject)
                    }
                pickerView.reloadAllComponents()
                 presentorDismissDatePickerWithAnimation()
                } else if sender?.tag == 1 {
                    suratAyatCount()
                    pickerView.reloadAllComponents()
                    presentorDismissDatePickerWithAnimation()
                } else if sender?.tag == 2 {
                    suratAyatCount()
                    pickerView.reloadAllComponents()
                    presentorDismissDatePickerWithAnimation()
                } else {
                    pickerDataSource?.append("YES" as AnyObject)
                    pickerDataSource?.append("NO" as AnyObject)
                    pickerView.reloadAllComponents()
                    presentorDismissDatePickerWithAnimation()
                }
            } else {
                pickerViewHeightConstraint.constant = 0
                isShow = false
            }
    }
    
    func suratAyatCount() {
        if let title = suratBtn.currentTitle {
            let suratNo = Int(title)! - 1
            if let ayatCount = modelController?.suratModelList?[suratNo].ayatList?.count {
                for i in 1...ayatCount {
                    pickerDataSource?.append(i as AnyObject)
                }
            }
        }
    }
    
    func presentorDismissDatePickerWithAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveLinear, animations: { [weak self] in
            if !self!.isShow {
                self?.pickerViewHeightConstraint.constant = 166
                self?.isShow = true
            } else {
                self?.pickerViewHeightConstraint.constant = 0
                self?.isShow = false
            }
            
        },completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var rowValue = ""
        if let pickerDataSource = pickerDataSource, pickerDataSource.count > 0 {
            rowValue = String(describing: pickerDataSource[row])
        }
        let attString = NSAttributedString(string: rowValue, attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attString
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func dismiss(sender: AnyObject?) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func uploadImage(sender: AnyObject?) {
        present(imagePicker!, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(sender: self)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(sender: self)
    }
    
    func showCamera(){
        imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
    }
    
    func choosePicture(){
        imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
    }

    @IBAction func doSave(sender: AnyObject?) {
        if saveButton.tag == 0 {
            showAlert(withTitle: "Playlist Name", message: "Please enter playlist name")
        }
        else {
            if allAyatBtn.currentTitle == "NO" && Int(endAyatBtn.currentTitle!)! <= Int(startAyatBtn.currentTitle!)! {
            showValidationAlert(withTitle: "Alert", message: "End Ayat cannot be less than or equal to start ayat")
            } else{
                showValidationAlert(withTitle: "Success", message: "Customize Surat added successfully")
                addOrUpdatePlayList()
                
            }
        }
    }
    
    func addOrUpdatePlayList() {
        let userDefault = UserDefaults.standard
        if let list = userDefault.value(forKey: "playLists") as? [AnyObject]{
            playLists = list
            userDefault.removeObject(forKey: "playLists")
        }
        var dictionary = [String: AnyObject]()
        var suratDictionary = [String: String]()
        var suratList = [AnyObject]()
        if playLists == nil || playLists?.count == 0 {
            playLists = []
            suratDictionary["surat"] = suratBtn.currentTitle
            if allAyatBtn.currentTitle == "YES" {
                guard let suratIndex = suratBtn.currentTitle else { return }
                guard let ayatCount = modelController?.suratModelList?[Int(suratIndex)! - 1].ayatList?.count else { return }
                suratDictionary["start"] = "1"
                suratDictionary["end"] = String(ayatCount)
            } else {
                suratDictionary["start"] = startAyatBtn.currentTitle
                suratDictionary["end"] = endAyatBtn.currentTitle
            }
            suratList.append(suratDictionary as AnyObject)
            dictionary["playList"] = playList?.text as AnyObject?
            if let image = imageView?.image {
                dictionary["image"] = UIImagePNGRepresentation(image) as AnyObject?
            }
            dictionary["surats"] = suratList as AnyObject?
            playLists?.append(dictionary as AnyObject)
        } else {
            var i = 0
            var isExistingPlayList = false
                for playListDict in playLists! {
                    if playListDict["playList"] as? String == playList?.text {
                        suratDictionary["surat"] = suratBtn.currentTitle
                        if allAyatBtn.currentTitle == "YES" {
                            guard let suratIndex = suratBtn.currentTitle else { return }
                            let ayatCount = modelController?.suratModelList?[Int(suratIndex)! - 1 ].ayatList?.count
                            suratDictionary["start"] = "1"
                            suratDictionary["end"] = String(ayatCount!)
                        } else {
                            suratDictionary["start"] = startAyatBtn.currentTitle
                            suratDictionary["end"] = endAyatBtn.currentTitle
                        }
                        for surats in playListDict["surats"] as! [AnyObject] {
                            var dictionary = [String: String]()
                            dictionary = surats as! [String : String]
                            suratList.append(dictionary as AnyObject)
                        }
                        suratList.append(suratDictionary as AnyObject)
                        dictionary["playList"] = playList?.text as AnyObject?
                        dictionary["surats"] = suratList as AnyObject?
                        let image = UIImage(data: playListDict["image"] as! Data)
                        dictionary["image"] = UIImagePNGRepresentation(image!) as AnyObject?
                        playLists?.append(dictionary as AnyObject)
                        playLists?.remove(at: i)
                        isExistingPlayList = true
                    }
                    i = i + 1
                }
             if !isExistingPlayList {
                suratDictionary["surat"] = suratBtn.currentTitle
                if allAyatBtn.currentTitle == "YES" {
                    guard let suratIndex = suratBtn.currentTitle else { return }
                    let ayatCount = modelController?.suratModelList?[Int(suratIndex)! - 1].ayatList?.count
                    suratDictionary["start"] = "1"
                    suratDictionary["end"] = String(ayatCount!)
                } else {
                    suratDictionary["start"] = startAyatBtn.currentTitle
                    suratDictionary["end"] = endAyatBtn.currentTitle
                }
                suratList.append(suratDictionary as AnyObject)
                dictionary["playList"] = playList?.text as AnyObject?
                if let image = imageView?.image {
                    dictionary["image"] = UIImagePNGRepresentation(image) as AnyObject?
                }
                dictionary["surats"] = suratList as AnyObject?
                playLists?.append(dictionary as AnyObject)
            }
        }
        userDefault.set(playLists, forKey:"playLists")
        userDefault.synchronize()
    }
    
    func showValidationAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil))
        present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func showAlert(withTitle title: String?, message: String?) {
        var isNameExist = false
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{[weak self] (UIAlertAction)in
            guard let strongSelf = self else { return }
            let textField = (alert.textFields![0]) as UITextField
            if let value = textField.text, value.characters.count == 0 {
                strongSelf.present(alert, animated: true, completion: {
                    print("completion block")
                })
                return
            } else if strongSelf.allAyatBtn.currentTitle == "NO" && Int(strongSelf.endAyatBtn.currentTitle!)! <= Int(strongSelf.startAyatBtn.currentTitle!)! {
                strongSelf.showValidationAlert(withTitle: "Alert", message: "End Ayat cannot be less than or equal to start ayat")
            } else {
                if let playLists = strongSelf.playLists {
                    for playListDict in playLists {
                        if playListDict["playList"] as? String == strongSelf.playList?.text {
                            isNameExist = true
                            strongSelf.showValidationAlert(withTitle: "Alert", message: "Name already exist. Please choose the different name")
                        }
                    }
                }
                if !isNameExist {
                    strongSelf.saveButton.title = "Add"
                    strongSelf.saveButton.tag = 1
                    strongSelf.suratBtn.titleLabel?.text = "1"
                    strongSelf.allAyatBtn.titleLabel?.text = "NO"
                    strongSelf.startAyatBtn.titleLabel?.text = "1"
                    strongSelf.startAyatBtn.titleLabel?.text = "2"
                    strongSelf.showValidationAlert(withTitle: "Success", message: "Playlist created successfully. You can also add more customize surat on the same playList. By modifying the surat and then clicking on the add button.")
                    strongSelf.addOrUpdatePlayList()
                }
            }
            print("User click Ok button")
        }))
        present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func configurationTextField(textField: UITextField!)
    {
        print("configurat hire the TextField")
        
         if let tField = textField {
            playList = tField
        }
    }
    
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("User click Cancel button")
    }
}
