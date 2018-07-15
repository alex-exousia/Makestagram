//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Alexander Niehaus on 7/14/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

class PostHeaderCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) { print("optionsButtonTapped")
    }
    
}
