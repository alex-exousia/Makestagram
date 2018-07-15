//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Alexander Niehaus on 7/15/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    

    @IBAction func likeButtonTapped(_ sender: Any) {
        
    }
    
     static let height: CGFloat = 46
}
