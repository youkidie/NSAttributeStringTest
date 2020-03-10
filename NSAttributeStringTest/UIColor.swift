//
//  UIColor.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat){
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    func createColorImage() -> UIImage {
        // 1x1のbitmapを作成
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { assertionFailure(); return UIImage() }
        // bitmapを塗りつぶし
        context.setFillColor(self.cgColor)
        context.fill(rect)
        // UIImageに変換
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { assertionFailure(); return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
