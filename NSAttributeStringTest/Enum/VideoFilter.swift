//
//  VideoFilter.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/19.
//  Copyright © 2020 tolv. All rights reserved.
//

enum VideoFilter: Int, CaseIterable {
    case CIBoxBlur
    case CIDiscBlur
    case CIGaussianBlur
    case CIMedianFilter
    case CIMotionBlur
    case CINoiseReduction
    case CIZoomBlur
    case CIColorClamp
    case CIColorControls
    case CIColorMatrix
    
    var valueKeys:[FilterParameter] {
        switch self {
        case .CIBoxBlur:
            return [.inputRadius]
        case .CIDiscBlur:
            return [.inputRadius]
        case .CIGaussianBlur:
            return [.inputRadius]
        case .CIMotionBlur:
            return [.inputRadius, .inputAngle]
        case .CINoiseReduction:
            return [.inputNoiseLevel, .inputSharpness]
        case .CIZoomBlur:
            return [.inputAmount]
        case .CIColorControls:
            return [.inputSaturation, .inputBrightness, .inputContrast]
        default:
            return []
        }
    }
    
    var vectorValueKeys:[FilterParameterVector] {
        switch self {
        case .CIZoomBlur:
            return [.inputCenter]
        case .CIColorClamp:
            return [.inputMinComponents, .inputMinComponents]
        case .CIColorMatrix:
            return [.inputRVector, .inputGVector, .inputBVector, .inputAVector, .inputBiasVector]
        default:
            return []
        }
    }
}

extension VideoFilter {
    var screenName: String {
        return converted(VideoFilterName.self).rawValue
    }
    
    private init?<T>(_ t: T?) {
        guard let t = t else { return nil }
        self = unsafeBitCast(t, to: VideoFilter.self)
    }
    
    private func converted<T>(_ t: T.Type) -> T {
        return unsafeBitCast(self, to: t)
    }
}

enum VideoFilterName: String {
    case CIBoxBlur
    case CIDiscBlur
    case CIGaussianBlur
}

enum FilterParameter: String {
    case inputRadius
    case inputAngle
    case inputNoiseLevel
    case inputSharpness
    case inputAmount
    case inputSaturation
    case inputBrightness
    case inputContrast
    
    var minimum:NSNumber {
        switch self {
        case .inputRadius:
            return 0.01
        case .inputAngle:
            return -3.141592653589793
        case .inputNoiseLevel:
            return 0
        case .inputSharpness:
            return 0
        case .inputAmount:
            return -200
        case .inputSaturation:
            return 0
        case .inputBrightness:
            return -1
        case .inputContrast:
            return 0.25
        default:
            return 0
        }
    }
    
    var maximum:NSNumber {
        switch self {
        case .inputRadius:
            return 400
        case .inputAngle:
            return 3.141592653589793
        case .inputNoiseLevel:
            return 0.1
        case .inputSharpness:
            return 1
        case .inputAmount:
            return 200
        case .inputSaturation:
            return 2
        case .inputBrightness:
            return 1
        case .inputContrast:
            return 4
        default:
            return 0
        }
    }
}

enum FilterParameterVector: String {
    case inputCenter
    case inputMinComponents
    case inputMaxComponents
    case inputRVector
    case inputGVector
    case inputBVector
    case inputAVector
    case inputBiasVector
    
    var minimum:[NSNumber] {
        switch self {
        case .inputCenter:
            return [0, 0]
        case .inputMinComponents:
            return [0, 0, 0, 0]
        case .inputMaxComponents:
            return [0, 0, 0, 0]
        case .inputRVector, .inputGVector, .inputBVector, .inputAVector, .inputBiasVector:
            return [0, 0, 0, 0]
        default:
            return [0, 0]
        }
    }
    
    var maximum:[NSNumber] {
        switch self {
        case .inputCenter:
            return [500, 500]
        case .inputMinComponents:
            return [1, 1, 1, 1]
        case .inputMaxComponents:
            return [1, 1, 1, 1]
        case .inputRVector, .inputGVector, .inputBVector, .inputAVector, .inputBiasVector:
            return [1, 1, 1, 1]
        default:
            return [0, 0]
        }
    }
}
