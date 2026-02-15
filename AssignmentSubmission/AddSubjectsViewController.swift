//
//  AddSubjectsViewController.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2023/01/24.
//

import UIKit
import NCMB

class AddSubjectsViewController: UIViewController {
    
    var selectedPath: Int = 0
    @IBOutlet var subjectsTextField: UITextField!
    @IBOutlet var classTextField: UITextField!
    var timer = Timer()
    @IBOutlet var selectSwitch: UISwitch!
    let content = UNMutableNotificationContent()
    var switchState:Int = 0
    var id:String!
    @IBOutlet var registerButton:UIButton!
    //var notificationDic:[String:String] = [:]
    //let ud = UserDefaults.standard
    //var notificationDic:[Int:String] = (ud.dictionary(forKey: "04") as? [Int:String]??)! [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 20
        if selectSwitch.isOn{
            switchState = 0
        }
        else{
            switchState = 1
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailSubjects = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailSubjectsViewController
        detailSubjects.notificationDic = notificationDic
    }
     */
     
    
    @IBAction func register() {
        
        let object = NCMBObject(className: "Subjects")
        object?.setObject(subjectsTextField.text, forKey: "subject")
        object?.setObject(classTextField.text, forKey: "class")
        object?.setObject(selectedPath, forKey: "jigen")
        if self.switchState == 0{
            if self.selectedPath % 6 == 0{
                print(0)
                id = UUID().uuidString
                self.content.body = "月曜日の授業の課題終わってますか？"
                self.setLocalNotification(id: id, title: self.subjectsTextField.text!, message: self.content.body, month: 0, day: 0, weekday: 6)
            }
            else if self.selectedPath % 6 == 1{
                print(1)
                id = UUID().uuidString
                self.content.body = "火曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: self.subjectsTextField.text!, message: self.content.body, month: 0, day: 0, weekday: 7)
            }
            else if self.selectedPath % 6 == 2{
                print(2)
                id = UUID().uuidString
                self.content.body = "水曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: self.subjectsTextField.text!, message: self.content.body, month: 0, day: 0, weekday: 1)
            }
            else if self.selectedPath % 6 == 3{
                print(3)
                id = UUID().uuidString
                self.content.body = "木曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: self.subjectsTextField.text!, message: self.content.body, month: 0, day: 0, weekday: 2)
            }
            else if self.selectedPath % 6 == 4{
                print(4)
                id = UUID().uuidString
                self.content.body = "金曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: self.subjectsTextField.text!, message: self.content.body, month: 0, day: 0, weekday: 3)
            }
            else if self.selectedPath % 6 == 5{
                print(5)
                id = UUID().uuidString
                self.content.body = "土曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: self.subjectsTextField.text!, message: self.content.body, month: 0, day: 0, weekday: 4)
            }
        }
        else{
            id = ""
        }
        object?.setObject(id, forKey: "notificationID")
        object?.saveInBackground{(error) in
            if error != nil{
                print(error!)
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func switchChanged(_ sender:UISwitch){
        if sender.isOn{
            switchState = 0
        }
        else{
            switchState = 1
        }
    }
    
    func setLocalNotification(id:String, title:String = "", message:String, month: Int, day: Int,hour:Int = 9, minute:Int = 0, second:Int = 0, weekday:Int){
        // タイトル、本文、サウンド設定の保持
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        
        var notificationTime = DateComponents()
        notificationTime.hour = 00
        notificationTime.minute = 00
        notificationTime.second = 00
        notificationTime.weekday = weekday
        
        let trigger: UNNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
        // 識別子とともに通知の表示内容とトリガーをrequestに内包
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // UNUserNotificationCenterにrequestを加える
        let center = UNUserNotificationCenter.current()
        center.delegate = UIApplication.shared.delegate as! AppDelegate
        center.add(request) { (error) in
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
}
