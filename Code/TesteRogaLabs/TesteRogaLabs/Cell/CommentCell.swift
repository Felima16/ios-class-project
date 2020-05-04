//
//  CommentCell.swift
//  TesteRogaLabs
//
//  Created by Fernanda de Lima on 04/05/20.
//  Copyright © 2020 Felima. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func setup(_ cell: Comment){
        nameLabel.text = cell.name
        emailLabel.text = cell.email
        bodyLabel.text = cell.body
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.bounds.height/2
    }
}
