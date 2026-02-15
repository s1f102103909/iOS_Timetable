//
//  DetailSubjectsViewController.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2023/02/04.
//

import UIKit
import NCMB

class DetailSubjectsViewController: UIViewController {
    
    var query:NCMBQuery!
    var subjectsArray = [NCMBObject]()
    var selectedPath:Int!
    var object:NCMBObject!
    var switchState:Int = 0
    
    
    @IBOutlet var classField:UITextField!
    @IBOutlet var subjetField:UITextField!
    @IBOutlet var selectSwitch: UISwitch!
    @IBOutlet var updateButton:UIButton!
    
    var classInfo:String!
    var subjectInfo:String!
    var id:String!
    let content = UNMutableNotificationContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        classField.text = classInfo
        subjetField.text = subjectInfo
        updateButton.layer.cornerRadius = 20
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController = segue.destination as! ViewController
        ViewController.dic1 = dic1
        ViewController.dic2 = dic2
    }
     */
    
    
    @IBAction func update(){
        let center = UNUserNotificationCenter.current()
        object?.setObject(subjetField.text, forKey: "subject")
        object?.setObject(classField.text, forKey: "class")
        if self.switchState == 0{
            if self.selectedPath % 6 == 0{
                print(0)
                id = UUID().uuidString
                self.content.body = "月曜日の授業の課題終わってますか？"
                self.setLocalNotification(id: id, title: subjetField.text!, message: self.content.body, month: 0, day: 0, weekday: 6)
            }
            else if self.selectedPath % 6 == 1{
                print(1)
                id = UUID().uuidString
                self.content.body = "火曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: subjetField.text!, message: self.content.body, month: 0, day: 0, weekday: 7)
            }
            else if self.selectedPath % 6 == 2{
                print(2)
                id = UUID().uuidString
                self.content.body = "水曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: subjetField.text!, message: self.content.body, month: 0, day: 0, weekday: 1)
            }
            else if self.selectedPath % 6 == 3{
                print(3)
                id = UUID().uuidString
                self.content.body = "木曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: subjetField.text!, message: self.content.body, month: 0, day: 0, weekday: 2)
            }
            else if self.selectedPath % 6 == 4{
                print(4)
                id = UUID().uuidString
                self.content.body = "金曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: subjetField.text!, message: self.content.body, month: 0, day: 0, weekday: 3)
            }
            else if self.selectedPath % 6 == 5{
                print(5)
                id = UUID().uuidString
                self.content.body = "土曜日の授業の課題終わっていますか？"
                self.setLocalNotification(id: id, title: subjetField.text!, message: self.content.body, month: 0, day: 0, weekday: 4)
            }
        }
        else{
            id = (object?.object(forKey: "notificationID") as? String)!
            if id != ""{
                center.removePendingNotificationRequests(withIdentifiers: [id])
                id = ""
                //print("成功")
            }
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
    
    
    
    @IBAction func delete(){
        let center = UNUserNotificationCenter.current()
        id = (object?.object(forKey: "notificationID") as? String)!
        if id != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id])
            //print("成功")
        }
        object?.deleteInBackground{(error) in
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
            
    func load() {
        self.query = NCMBQuery(className:"Subjects")
        self.query?.findObjectsInBackground({(result, error) in
            if error != nil {
                print(error!)
            }
            else {
                self.subjectsArray = result as! [NCMBObject]
                if self.subjectsArray.count == 0{return;}
                for i in 0...self.subjectsArray.count - 1{
                    if self.selectedPath == self.subjectsArray[i].object(forKey: "jigen") as? Int{
                        //print(self.subjectsArray[i])
                        self.object = self.subjectsArray[i]
                        //print(self.object!)
                        if ((self.object?.object(forKey: "notificationID") as? String) != ""){
                            self.selectSwitch.isOn = true
                            self.switchState = 0
                        }
                        else{
                            self.selectSwitch.isOn = false
                            self.switchState = 1
                        }
                    }
                }
            }
        })
    }
    
    func setLocalNotification(id:String, title:String = "", message:String, month: Int, day: Int,hour:Int = 9, minute:Int = 0, second:Int = 0, weekday:Int = 0 ){
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
