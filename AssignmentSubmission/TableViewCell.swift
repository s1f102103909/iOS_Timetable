//
//  TableViewCell.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2023/02/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var taskLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
