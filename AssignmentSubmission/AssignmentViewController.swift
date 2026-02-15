//
//  AssignmentViewController.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2022/12/23.
//

import UIKit
import NCMB

class AssignmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var taskArray = [NCMBObject]()
    @IBOutlet var taskTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
        
        taskTableView.rowHeight = 100
        
        let nib = UINib(nibName: "TableViewCell", bundle: Bundle.main)
        taskTableView.register(nib, forCellReuseIdentifier: "Cell")
        
        let availableWidth = taskTableView.bounds.inset(by: taskTableView.adjustedContentInset).width
        let prototypeCell = UINib(nibName: "TableViewCell", bundle: nil).instantiate(withOwner: nil,options: nil).first as! TableViewCell
        prototypeCell.systemLayoutSizeFitting(CGSize(width: availableWidth, height: 0),withHorizontalFittingPriority: .required,verticalFittingPriority: .defaultLow)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  taskTableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        cell.taskLabel?.text = taskArray[indexPath.row].object(forKey: "task") as? String
        cell.dateLabel?.text = taskArray[indexPath.row].object(forKey: "date") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let detailViewController = segue.destination as! DetailViewController
            let selectedIndex = taskTableView.indexPathForSelectedRow!
            detailViewController.selectedTask = taskArray[selectedIndex.row]
        }
    }

    
    func loadData(){
        let query = NCMBQuery(className: "Task")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error!)
            }
            else {
                self.taskArray = result as! [NCMBObject]
                //print(self.taskArray)
                //print(type(of: self.taskArray))
                self.taskTableView.reloadData()
            }
        })
    }
}
