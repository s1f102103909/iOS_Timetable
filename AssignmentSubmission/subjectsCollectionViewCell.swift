//
//  subjectsCollectionViewCell.swift
//  AssignmentSubmission
//
//  Created by 國分佑馬 on 2023/01/15.
//

import UIKit

class subjectsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var subjectName: UILabel!
    @IBOutlet var className: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
         
    }

}
