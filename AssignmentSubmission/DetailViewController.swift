//
//  DetailViewController.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2023/01/12.
//

import UIKit
import NCMB

class DetailViewController: UIViewController {
    
    var selectedTask: NCMBObject!
    @IBOutlet var taskTextView: UITextField!
    @IBOutlet var taskDatetime: UITextField!
    @IBOutlet var updateButton:UIButton!
    
    var datePicker = UIDatePicker()
    let formatter = DateFormatter()
    
    var timeInterval_1hour:Double = 0.0
    var timeInterval_1day:Double = 0.0
    var timeInterval_2day:Double = 0.0
    var hour: Int = 0
    var minute: Int = 0
    var month: Int = 0
    var day: Int = 0
    
    var id_1hour:String!
    var id_1day:String!
    var id_2day:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateButton.layer.cornerRadius = 20
        taskTextView.text = selectedTask.object(forKey: "task") as? String
        taskDatetime.text = selectedTask.object(forKey: "date") as? String
        
        id_1hour = selectedTask.object(forKey: "id_1hour") as? String
        id_1day = selectedTask.object(forKey: "id_1day") as? String
        id_2day = selectedTask.object(forKey: "id_2day") as? String
        
        if id_1hour != ""{
            button_1hour.backgroundColor = UIColor.systemBlue
            button_1hour.tintColor = UIColor.white
            timeInterval_1hour = -60.0*60
        }
        if id_1day != ""{
            button_1day.backgroundColor = UIColor.systemBlue
            button_1day.tintColor = UIColor.white
            timeInterval_1day = -60.0*60*24
        }
        if id_2day != ""{
            button_2day.backgroundColor = UIColor.systemBlue
            button_2day.tintColor = UIColor.white
            timeInterval_2day = -60.0*60*24*2
        }
        
        
        configurePicker()
        let date = Date()
    }
    
    class func dateFromString(string: String, format: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = .current
        formatter.dateFormat = format
        return formatter.date(from: string)
    }

    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    @IBAction func update(){
        let center = UNUserNotificationCenter.current()
        if id_1hour != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id_1hour])
            id_1hour = ""
        }
        if id_1day != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id_1day])
            id_1day = ""
        }
        if id_2day != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id_2day])
            id_2day = ""
        }
        if timeInterval_1hour != 0.0{
            let date = Date()
            print(date,"現在時刻")
            let dateString = taskDatetime.text
            // String→Dateに変換
            let date1 = AddViewController.dateFromString(string: dateString!, format: "YYYY年MM月dd日HH時mm分")!
            let newDate = Date(timeInterval: timeInterval_1hour, since: date1)
            let newDateString = AddViewController.stringFromDate(date: newDate, format: "YYYY年MM月dd日HH時mm分")
            id_1hour = UUID().uuidString //ランダムな文字列をidに代入
            //"MM月dd日HH時mm分"のMMをとる
            let YYYY = newDateString.prefix(4)
            let MM = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 5)...newDateString.index(newDateString.startIndex, offsetBy: 6)]
            //"MM月dd日HH時mm分"のddをとる
            let dd = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 8)...newDateString.index(newDateString.startIndex, offsetBy: 9)]
            //"MM月dd日HH時mm分"のHHをとる
            let HH = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 11)...newDateString.index(newDateString.startIndex, offsetBy: 12)]
            //"MM月dd日HH時mm分"のmmをとる
            let mm = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 14)...newDateString.index(newDateString.startIndex, offsetBy: 15)]
           //notificationDayの月日時分の情報をInt型で取得
            month = Int(MM)!
            day = Int(dd)!
            hour = Int(HH)!
            minute = Int(mm)!
            
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "國分さん"
            content.body = "課題終わってますか？"
            
            setLocalNotification(id: id_1hour, title: content.title, message: content.body, month: month, day: day, hour: hour, minute: minute, second: 00)
        }
        
        if timeInterval_1day != 0.0{
            let date = Date()
            print(date,"現在時刻")
            let dateString = taskDatetime.text
            // String→Dateに変換
            let date1 = AddViewController.dateFromString(string: dateString!, format: "YYYY年MM月dd日HH時mm分")!
            let newDate = Date(timeInterval: timeInterval_1day, since: date1)
            let newDateString = AddViewController.stringFromDate(date: newDate, format: "YYYY年MM月dd日HH時mm分")
            id_1day = UUID().uuidString //ランダムな文字列をidに代入
            //"MM月dd日HH時mm分"のMMをとる
            let YYYY = newDateString.prefix(4)
            let MM = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 5)...newDateString.index(newDateString.startIndex, offsetBy: 6)]
            //"MM月dd日HH時mm分"のddをとる
            let dd = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 8)...newDateString.index(newDateString.startIndex, offsetBy: 9)]
            //"MM月dd日HH時mm分"のHHをとる
            let HH = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 11)...newDateString.index(newDateString.startIndex, offsetBy: 12)]
            //"MM月dd日HH時mm分"のmmをとる
            let mm = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 14)...newDateString.index(newDateString.startIndex, offsetBy: 15)]
            //notificationDayの月日時分の情報をInt型で取得
            month = Int(MM)!
            day = Int(dd)!
            hour = Int(HH)!
            minute = Int(mm)!
            
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "國分さん"
            content.body = "課題終わってますか？"
            
            setLocalNotification(id: id_1day, title: content.title, message: content.body, month: month, day: day, hour: hour, minute: minute, second: 00)
        }
        
        if timeInterval_2day != 0.0{
            let date = Date()
            print(date,"現在時刻")
            let dateString = taskDatetime.text
            // String→Dateに変換
            let date1 = AddViewController.dateFromString(string: dateString!, format: "YYYY年MM月dd日HH時mm分")!
            let newDate = Date(timeInterval: timeInterval_2day, since: date1)
            let newDateString = AddViewController.stringFromDate(date: newDate, format: "YYYY年MM月dd日HH時mm分")
            id_2day = UUID().uuidString //ランダムな文字列をidに代入
            //"MM月dd日HH時mm分"のMMをとる
            let YYYY = newDateString.prefix(4)
            let MM = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 5)...newDateString.index(newDateString.startIndex, offsetBy: 6)]
            //"MM月dd日HH時mm分"のddをとる
            let dd = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 8)...newDateString.index(newDateString.startIndex, offsetBy: 9)]
            //"MM月dd日HH時mm分"のHHをとる
            let HH = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 11)...newDateString.index(newDateString.startIndex, offsetBy: 12)]
            //"MM月dd日HH時mm分"のmmをとる
            let mm = newDateString[newDateString.index(newDateString.startIndex, offsetBy: 14)...newDateString.index(newDateString.startIndex, offsetBy: 15)]
           //notificationDayの月日時分の情報をInt型で取得
            month = Int(MM)!
            day = Int(dd)!
            hour = Int(HH)!
            minute = Int(mm)!
            
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "國分さん"
            content.body = "課題終わってますか？"
            
            setLocalNotification(id: id_2day, title: content.title, message: content.body, month: month, day: day, hour: hour, minute: minute, second: 00)
        }
        
        selectedTask.setObject(id_1hour, forKey: "id_1hour")
        selectedTask.setObject(id_1day, forKey: "id_1day")
        selectedTask.setObject(id_2day, forKey: "id_2day")
        selectedTask.setObject(taskTextView.text, forKey: "task")
        selectedTask.setObject(taskDatetime.text, forKey: "date")
        selectedTask.saveInBackground {(error) in
            if error != nil {
                print(error!)
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func delete(){
        let center = UNUserNotificationCenter.current()
        if id_1hour != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id_1hour])
        }
        if id_1day != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id_1day])
        }
        if id_2day != ""{
            center.removePendingNotificationRequests(withIdentifiers: [id_2day])
        }
        selectedTask.deleteInBackground { (error) in
            if error != nil {
                print(error!)
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func configurePicker() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(doneDatePicker))
        toolBar.setItems([spaceItem,doneItem], animated: true)
        formatter.dateFormat = "YYYY年MM月dd日HH時mm分"
        //taskDatetime?.text = formatter.string(from: Date())
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        taskDatetime?.inputView = datePicker
        taskDatetime?.inputAccessoryView = toolBar
      }
    
    @objc func doneDatePicker(){
        formatter.dateFormat = "YYYY年MM月dd日HH時mm分"
        //taskDatetime.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
      }
    
    func setLocalNotification(id:String, title:String = "", message:String, month: Int, day: Int,hour:Int = 9, minute:Int = 0, second:Int = 0 ){
        // タイトル、本文、サウンド設定の保持
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default

        var notificationTime = DateComponents()
        notificationTime.month = month
        notificationTime.day = day
        notificationTime.hour = hour
        notificationTime.minute = minute
        notificationTime.second = second

        let trigger: UNNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        // 識別子とともに通知の表示内容とトリガーをrequestに内包
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        // UNUserNotificationCenterにrequestを加える
        let center = UNUserNotificationCenter.current()
        center.delegate = UIApplication.shared.delegate as! AppDelegate
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBOutlet var button_1hour:UIButton!
    @IBOutlet var button_1day:UIButton!
    @IBOutlet var button_2day:UIButton!
    
    @IBAction func checkBox_1hour(_ sender:UIButton){
        if button_1hour.backgroundColor == UIColor.white{
            button_1hour.backgroundColor = UIColor.systemBlue
            button_1hour.tintColor = UIColor.white
            timeInterval_1hour = -60.0*60
        }
        else{
            button_1hour.backgroundColor = UIColor.white
            button_1hour.tintColor = UIColor.systemBlue
            timeInterval_1hour = 0.0
        }
    }
    
    @IBAction func checkBox_1day(_ sender:UIButton){
        if button_1day.backgroundColor == UIColor.white{
            button_1day.backgroundColor = UIColor.systemBlue
            button_1day.tintColor = UIColor.white
            timeInterval_1day = -60.0*60*24
        }
        else{
            button_1day.backgroundColor = UIColor.white
            button_1day.tintColor = UIColor.systemBlue
            timeInterval_1day = 0.0
        }
    }
    
    @IBAction func checkBox_2day(_ sender:UIButton){
        if button_2day.backgroundColor == UIColor.white{
            button_2day.backgroundColor = UIColor.systemBlue
            button_2day.tintColor = UIColor.white
            timeInterval_2day = -60.0*60*48
        }
        else{
            button_2day.backgroundColor = UIColor.white
            button_2day.tintColor = UIColor.systemBlue
            timeInterval_2day = 0.0
        }
    }
}
