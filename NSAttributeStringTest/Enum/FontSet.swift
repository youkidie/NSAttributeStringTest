//
//  FontSet.swift
//  NSAttributeStringTest
//
//  Created by d.yukimoto on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit

enum FontSet: Int, CaseIterable {
    case hiraginoKakuGoW8
    case roundedMplus
    case lightNovelPop
    case cinecaption
    case logoTypeGo
    case hiraginoMinchoProN
}

extension FontSet {
    var fontName: String {
        return converted(FontName.self).rawValue
    }
    
    var fontSystemName: String {
        return converted(FontSystemName.self).rawValue
    }
    
    var resourceName: String {
        return converted(FontResourceName.self).rawValue
    }
    
    private init?<T>(_ t: T?) {
        guard let t = t else { return nil }
        self = unsafeBitCast(t, to: FontSet.self)
    }
    
    private func converted<T>(_ t: T.Type) -> T {
        return unsafeBitCast(self, to: t)
    }
}

enum FontName: String {
    case hiraginoKakuGoW8 = "ヒラギノ角ゴシック W8"
    case roundedMplus = "Rounded M+ 1p bold"
    case lightNovelPop = "07ラノベPOP Regular"
    case cinecaption = "しねきゃぷしょん Regular"
    case logoTypeGo = "07ロゴたいぷゴシック7 Regular"
    case hiraginoMinchoProN = "ヒラギノ明朝 ProN W6"
}

enum FontSystemName: String {
    case hiraginoKakuGoW8 = "HiraginoSans-W8"
    case roundedMplus = "rounded-mplus-1p-bold"
    case lightNovelPop = "07LightNovelPOP"
    case cinecaption = "cinecaption"
    case logoTypeGo = "07LogoTypeGothic7"
    case hiraginoMinchoProN = "HiraMinProN-W6"
}

enum FontResourceName: String {
    case hiraginoKakuGoW8 = "Kakugo"
    case roundedMplus = "Marugo"
    case lightNovelPop = "Pop"
    case cinecaption = "Cinema"
    case logoTypeGo = "Design"
    case hiraginoMinchoProN = "Mincho"
}
