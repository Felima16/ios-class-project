//
//  PostCell.swift
//  TesteRogaLabs
//
//  Created by Fernanda de Lima on 04/05/20.
//  Copyright © 2020 Felima. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func setupCell(_ cell: Post){
        titleLabel.text = cell.title
        bodyLabel.text = cell.body
    }
}
