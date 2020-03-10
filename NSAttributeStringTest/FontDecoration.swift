//
//  FontDecoration.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

enum FontDecoration: Int, CaseIterable {
    case color
    case white
    case colorCushion
    case whiteCushion
}

extension FontDecoration {
    var resourceName: String {
        return converted(FontDecorationResourceName.self).rawValue
    }
    
    private init?<T>(_ t: T?) {
        guard let t = t else { return nil }
        self = unsafeBitCast(t, to: FontDecoration.self)
    }
    
    private func converted<T>(_ t: T.Type) -> T {
        return unsafeBitCast(self, to: t)
    }
}

enum FontDecorationResourceName: String {
    case color = "deco_color"
    case white = "deco_white"
    case colorCushion = "deco_color_cushion"
    case whiteCushion = "deco_white_cushion"
}

