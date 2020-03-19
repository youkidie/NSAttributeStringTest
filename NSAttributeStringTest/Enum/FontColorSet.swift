//
//  FontColorSet.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit

enum FontColorSet: Int, CaseIterable {
    /// 0 127 255
    case vividBlue
    /// 0 0 0
    case black
    /// 255 0 0
    case vividRed
    /// 255 127 0
    case vividOrange
    /// 255 255 0
    case vividYellow
    /// 255 0 255
    case vividGreen
    /// 0 0 255
    case vividIndigo
    /// 127 0 255
    case vividViolet
    /// 255 127 127
    case pastelRed
    /// 255 191 127
    case pastelOrange
    /// 255 255 127
    case pastelYellow
    /// 127 255 127
    case pastelGreen
    /// 127 191 255
    case pastelBlue
    /// 127 127 255
    case pastelIndigo
    /// 191 127 255
    case pastelViolet
    
    var uiColor:UIColor {
        switch self {
        case .black:
            return UIColor(red: 0, green: 0, blue: 0)
        case .vividRed:
            return UIColor(red: 255, green: 0, blue: 0)
        case .vividOrange:
            return UIColor(red: 255, green: 127, blue: 0)
        case .vividYellow:
            return UIColor(red: 255, green: 255, blue: 0)
        case .vividGreen:
            return UIColor(red: 0, green: 255, blue: 0)
        case .vividBlue:
            return UIColor(red: 0, green: 127, blue:255)
        case .vividIndigo:
            return UIColor(red: 0, green: 0, blue:255)
        case .vividViolet:
            return UIColor(red: 127, green: 0, blue:255)
        case .pastelRed:
            return UIColor(red: 255, green: 127, blue:127)
        case .pastelOrange:
            return UIColor(red: 255, green: 191, blue:127)
        case .pastelYellow:
            return UIColor(red: 255, green: 255, blue:127)
        case .pastelGreen:
            return UIColor(red: 127, green: 255, blue:127)
        case .pastelBlue:
            return UIColor(red: 127, green: 191, blue:255)
        case .pastelIndigo:
            return UIColor(red: 127, green: 127, blue:255)
        case .pastelViolet:
            return UIColor(red: 191, green: 127, blue:255)
        }
    }
    
    var cgColor: CGColor {
        return self.uiColor.cgColor
    }
    
    var insideColor: UIColor {
        switch self {
        case .black, .vividRed, .vividOrange, .vividBlue, .vividIndigo, .vividViolet, .pastelRed, .pastelOrange, .pastelBlue, .pastelIndigo, .pastelViolet:
            return UIColor(red: 255, green: 255, blue:255)
        case .vividYellow, .vividGreen, .pastelYellow, .pastelGreen:
            return UIColor(red: 0, green: 0, blue: 0)
        }
    }
}
