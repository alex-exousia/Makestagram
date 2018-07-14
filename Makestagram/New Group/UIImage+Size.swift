//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Alexander Niehaus on 7/13/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
