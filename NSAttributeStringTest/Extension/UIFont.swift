//
//  UIFont.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit

extension UIFont {
    convenience init?(fontSet: FontSet, size: CGFloat) {
        self.init(name:fontSet.fontSystemName, size:size)
    }
}
