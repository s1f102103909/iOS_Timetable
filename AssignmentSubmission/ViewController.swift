//
//  ViewController.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2022/12/23.
//

import UIKit
import NCMB
import PTCardTabBar
import SOTabBar

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var subjectArray = [NCMBObject]()
    @IBOutlet var timescheduleCollectionView: UICollectionView!
    
    
    var dicSubject:[Int:String] = [:]
    var dicClass:[Int:String] = [:]
    var dic1 :Array<(key: Int, value: String)> = []
    var dic2 :Array<(key: Int, value: String)> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        timescheduleCollectionView.dataSource = self
        timescheduleCollectionView.delegate = self
        //timescheduleCollectionView.isScrollEnabled = false
        
        timescheduleCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let nib = UINib(nibName: "subjectsCollectionViewCell", bundle: Bundle.main)
        timescheduleCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        
        let layout = UICollectionViewFlowLayout()
        let numIndex = CGFloat(7)
        let numColumns = CGFloat(6)
    
        
        let availableWidth = timescheduleCollectionView.bounds.inset(by: timescheduleCollectionView.adjustedContentInset).width
        let availableHeight = timescheduleCollectionView.bounds.inset(by: timescheduleCollectionView.adjustedContentInset).height
        print(availableWidth)
        print(availableHeight)
        let cellWidth = (availableWidth / numColumns).rounded(.down)
        let cellHeight = (availableHeight / numIndex).rounded(.down)
        print(cellWidth)
        print(cellHeight)
        
        //iPhoneSE 53:71
        //iPhone14Pro 56:87.9
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        timescheduleCollectionView.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = timescheduleCollectionView.bounds.inset(by: timescheduleCollectionView.adjustedContentInset).width
        let availableHeight = timescheduleCollectionView.bounds.inset(by: timescheduleCollectionView.adjustedContentInset).height
        let numIndex = CGFloat(7)
        let numColumns = CGFloat(6)
        let cellWidth = (availableWidth / numColumns).rounded(.down)
        let cellHeight = (availableHeight / numIndex).rounded(.down)
        
        let prototypeCell = UINib(nibName: "subjectsCollectionViewCell", bundle: nil).instantiate(withOwner: nil,options: nil).first as! subjectsCollectionViewCell
        return prototypeCell.systemLayoutSizeFitting(CGSize(width: cellWidth, height: cellHeight),withHorizontalFittingPriority: .required,verticalFittingPriority: .required)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedIndex = timescheduleCollectionView.indexPathsForSelectedItems!
        self.timescheduleCollectionView.reloadItems(at: selectedIndex)
        //print(selectedIndex)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.dic1.count == 0{
            self.performSegue(withIdentifier: "register", sender: nil)
            return;
        }
        for i in 0...self.dic1.count - 1 {
            if indexPath.row == self.dic1[i].key {
                self.performSegue(withIdentifier: "detail", sender: nil)
                return;
            }
        }
        self.performSegue(withIdentifier: "register", sender: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.dicSubject = [:]
        self.dicClass = [:]
        self.dic1 = []
        self.dic2 = []
        //print(self.dic1)
        //print(indexPath.row)
        let cell = timescheduleCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! subjectsCollectionViewCell
        cell.subjectName?.text = ""
        cell.className?.text = ""
        
            let query = NCMBQuery(className:"Subjects")
            query?.findObjectsInBackground({(result, error) in
                if error != nil {
                    print(error!)
                }
                else {
                    self.subjectArray = result as! [NCMBObject]
                    //print(self.subjectArray.count)
                    if self.subjectArray.count == 0{ return;}
                    
                    for i in 0...self.subjectArray.count - 1{
                        let index = self.subjectArray[i].object(forKey: "jigen") as? Int
                        let subject = self.subjectArray[i].object(forKey: "subject") as? String
                        let classname = self.subjectArray[i].object(forKey: "class") as? String
                        self.dicSubject.updateValue(subject!, forKey: index!)
                        self.dicClass.updateValue(classname!, forKey: index!)
                    }
                    //print(self.dicSubject)
                    
                    self.dic1 = self.dicSubject.sorted(by: <)
                    self.dic2 = self.dicClass.sorted(by: <)
                    for i in 0...self.dic1.count - 1 {
                        if indexPath.row == self.dic1[i].key {
                            cell.subjectName?.text = self.dic1[i].value
                            cell.className?.text = self.dic2[i].value
                            //print(self.dic1)
                            return;
                        }
                    }
                    cell.subjectName?.text = ""
                    cell.className?.text = ""
                }
            })
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = timescheduleCollectionView.indexPathsForSelectedItems!
        if segue.identifier == "register"{
            let AddSubjectsViewController = segue.destination as! AddSubjectsViewController
            AddSubjectsViewController.selectedPath = selectedIndex[0][1]
        }
        else if segue.identifier == "detail"{
            let detailSubjectsViewController = segue.destination as! DetailSubjectsViewController
            for i in 0...dic1.count - 1{
                if selectedIndex[0][1] == dic1[i].key{
                    detailSubjectsViewController.subjectInfo = dic1[i].value
                    detailSubjectsViewController.classInfo = dic2[i].value
                    detailSubjectsViewController.selectedPath = selectedIndex[0][1]
                }
            }
        }
    }
    
}




