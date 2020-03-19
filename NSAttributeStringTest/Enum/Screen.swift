//
//  Screen.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/19.
//  Copyright © 2020 tolv. All rights reserved.
//

enum Screen: Int, CaseIterable {
    case LabelTest
    case DramrollTest
    case VideoFilterTest
    case RealtimeVideoFilterTest
}

extension Screen {
    var screenName: String {
        return converted(ScreenName.self).rawValue
    }
    
    private init?<T>(_ t: T?) {
        guard let t = t else { return nil }
        self = unsafeBitCast(t, to: Screen.self)
    }
    
    private func converted<T>(_ t: T.Type) -> T {
        return unsafeBitCast(self, to: t)
    }
}

enum ScreenName: String {
    case LabelTest                   = "Label Test"
    case DramrollTest                = "Dramroll UI Test"
    case VideoFilterTest             = "Video Filter Test"
    case RealtimeVideoFilterTest     = "Realtime Video Filter Test"
}
