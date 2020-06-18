//
//  JKCSImageListTableViewCell.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-15.
//  Copyright © 2020 Kuang. All rights reserved.
//

import UIKit

class JKCSImageListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    static let reuseId = "JKCSImageListTableViewCell"
    static let nibName = "JKCSImageListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.image = UIImage(systemName: "photo")
        thumbnailImageView.tintColor = .lightGray
        accessoryType = .disclosureIndicator
    }
    
}
