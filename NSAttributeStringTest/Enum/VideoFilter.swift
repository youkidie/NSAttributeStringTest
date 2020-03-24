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
    case CIColorPolynomial
    case CIExposureAdjust
    case CIGammaAdjust
    case CIHueAdjust
    case CILinearToSRGBToneCurve
    case CISRGBToneCurveToLinear
    case CITemperatureAndTint
    case CIToneCurve
    case CIVibrance
    case CIWhitePointAdjust
//    case CIColorCrossPolynomial
    // use cube data
//    case CIColorCube
//    case CIColorCubeWithColorSpace
    case CIColorInvert
//    case CIColorMap
    case CIColorMonochrome
    case CIColorPosterize
    case CIFalseColor
    case CIMaskToAlpha
    case CIMaximumComponent
    case CIMinimumComponent
    case CIPhotoEffectChrome
    case CIPhotoEffectFade
    case CIPhotoEffectInstant
    case CIPhotoEffectMono
    case CIPhotoEffectNoir
    case CIPhotoEffectProcess
    case CIPhotoEffectTonal
    case CIPhotoEffectTransfer
    case CISepiaTone
    case CIVignette
    case CIVignetteEffect
    // mix2image
//    case CIAdditionCompositing
//    case CIColorBlendMode
//    case CIColorBurnBlendMode
//    case CIColorDodgeBlendMode
//    case CIDarkenBlendMode
//    case CIDifferenceBlendMode
//    case CIDivideBlendMode
//    case CIExclusionBlendMode
//    case CIHardLightBlendMode
//    case CIHueBlendMode
//    case CILightenBlendMode
//    case CILinearBurnBlendMode
//    case CILinearDodgeBlendMode
//    case CILuminosityBlendMode
//    case CIMaximumCompositing
//    case CIMinimumCompositing
//    case CIMultiplyBlendMode
//    case CIMultiplyCompositing
//    case CIOverlayBlendMode
//    case CIPinLightBlendMode
//    case CISaturationBlendMode
//    case CIScreenBlendMode
//    case CISoftLightBlendMode
//    case CISourceAtopCompositing
//    case CISourceInCompositing
//    case CISourceOutCompositing
//    case CISourceOverCompositing
//    case CISubtractBlendMode
    case CIBumpDistortion
    case CIBumpDistortionLinear
    case CICircleSplashDistortion
    case CICircularWrap
    case CIDroste
    // use texture
//    case CIDisplacementDistortion
//    case CIGlassDistortion
    case CIGlassLozenge
    case CIHoleDistortion
    case CILightTunnel
    case CIPinchDistortion
    case CIStretchCrop
    case CITorusLensDistortion
    case CITwirlDistortion
    case CIVortexDistortion
    // remake generator
//    case CIAztecCodeGenerator
//    case CICheckerboardGenerator
//    case CICode128BarcodeGenerator
//    case CIConstantColorGenerator
//    case CILenticularHaloGenerator
//    case CIPDF417BarcodeGenerator
//    case CIQRCodeGenerator
    case CIRandomGenerator
//    case CIStarShineGenerator
//    case CIStripesGenerator
//    case CISunbeamsGenerator
    // scale transform
//    case CIAffineTransform
//    case CICrop
//    case CILanczosScaleTransform
    case CIPerspectiveCorrection
    case CIPerspectiveTransform
//    case CIPerspectiveTransformWithExtent
    case CIStraightenFilter
//    case CIGaussianGradient
//    case CILinearGradient
//    case CIRadialGradient
//    case CISmoothLinearGradient
//    case CICircularScreen
    case CICMYKHalftone
//    case CIDotScreen
//    case CIHatchedScreen
//    case CILineScreen
    // ???
//    case CIAreaAverage
//    case CIAreaHistogram
//    case CIRowAverage
//    case CIColumnAverage
//    case CIHistogramDisplayFilter
//    case CIAreaMaximum
//    case CIAreaMinimum
//    case CIAreaMaximumAlpha
//    case CIAreaMinimumAlpha
    case CISharpenLuminance
    case CIUnsharpMask
//    case CIBlendWithAlphaMask
//    case CIBlendWithMask
    case CIBloom
    case CIComicEffect
//    case CIConvolution3X3
//    case CIConvolution5X5
//    case CIConvolution7X7
//    case CIConvolution9Horizontal
//    case CIConvolution9Vertical
    case CICrystallize
    case CIDepthOfField
    case CIEdges
    case CIEdgeWork
    case CIGloom
    case CIHeightFieldFromMask
    case CIHexagonalPixellate
    case CIHighlightShadowAdjust
    case CILineOverlay
    case CIPixellate
    case CIPointillize
//    case CIShadedMaterial
//    case CISpotColor
    case CISpotLight
    
    var valueKeys:[FilterParameter] {
        switch self {
        case .CIBoxBlur, .CIDiscBlur, .CIGaussianBlur, .CICrystallize, .CIPointillize:
            return [.inputRadius]
        case .CIMotionBlur:
            return [.inputRadius, .inputAngle]
        case .CINoiseReduction:
            return [.inputNoiseLevel, .inputSharpness]
        case .CIZoomBlur:
            return [.inputAmount200]
        case .CIColorControls:
            return [.inputSaturation, .inputBrightness, .inputContrast]
        case .CIExposureAdjust:
            return [.inputEV]
        case .CIGammaAdjust:
            return [.inputPower]
        case .CIHueAdjust, .CIStraightenFilter:
            return [.inputAngle]
        case .CIVibrance:
            return [.inputAmount]
        case .CIColorMonochrome:
            return [.inputIntensity]
        case .CIColorPosterize:
            return [.inputLevels]
        case .CISepiaTone:
            return [.inputIntensity]
        case .CIVignette:
            return [.inputRadius2, .inputIntensityMinus]
        case .CIVignetteEffect:
            return [.inputRadius2000, .inputIntensityMinus, .inputFalloff]
        case .CIBumpDistortion:
            return [.inputRadius600, .inputScale]
        case .CIBumpDistortionLinear:
            return [.inputRadius600, .inputScale, .inputAngle]
        case .CICircleSplashDistortion, .CIHoleDistortion:
            return [.inputRadius1000]
        case .CICircularWrap:
            return [.inputRadius600, .inputAngle]
        case .CIDroste:
            return [.inputStrands, .inputPeriodicity, .inputRotation, .inputZoom]
        case .CIGlassLozenge:
            return [.inputRefraction, .inputRadius1000]
        case .CILightTunnel:
            return [.inputRotation, .inputRadius600]
        case .CIPinchDistortion:
            return [.inputRadius1000, .inputScale]
        case .CIStretchCrop:
            return [.inputCenterStretchAmount, .inputCropAmount]
        case .CITorusLensDistortion:
            return [.inputRadius600, .inputWidth, .inputRefraction]
        case .CITwirlDistortion:
            return [.inputRadius600, .inputAngle3]
        case .CIVortexDistortion:
            return [.inputRadius600, .inputAngle30]
        case .CICMYKHalftone:
            return [.inputWidth, .inputAngle, .inputSharpness, .inputGCR, .inputUCR]
        case .CISharpenLuminance:
            return [.inputSharpness]
        case .CIUnsharpMask, .CIBloom:
            return [.inputRadius, .inputIntensity]
        case .CIDepthOfField:
            return [.inputSaturation, .inputUnsharpMaskRadius, .inputUnsharpMaskIntensity, .inputRadius30]
        case .CIEdges:
            return [.inputIntensity10]
        case .CIEdgeWork:
            return [.inputRadius30]
        case .CIGloom:
            return [.inputIntensity, .inputRadius]
        case .CIHeightFieldFromMask:
            return [.inputRadius600]
        case .CIHexagonalPixellate, .CIPixellate:
            return [.inputScale100]
        case .CIHighlightShadowAdjust:
            return [.inputHighlightAmount, .inputShadowAmount]
        case .CILineOverlay:
            return [.inputNRNoiseLevel, .inputNRSharpness, .inputEdgeIntensity, .inputThreshold, .inputContrast200]
        case .CISpotLight:
            return [.inputConcentration, .inputBrightness10]
        default:
            return []
        }
    }
    
    var vectorValueKeys:[FilterParameterVector] {
        switch self {
        case .CIZoomBlur, .CIVignetteEffect, .CIBumpDistortion, .CIBumpDistortionLinear,
             .CICircleSplashDistortion, .CICircularWrap, .CIHoleDistortion, .CILightTunnel,
             .CIPinchDistortion, .CITorusLensDistortion, .CITwirlDistortion, .CIVortexDistortion,
             .CICMYKHalftone, .CICrystallize, .CIHexagonalPixellate, .CIPixellate, .CIPointillize:
            return [.inputCenter]
        case .CIColorClamp:
            return [.inputMinComponents, .inputMaxComponents]
        case .CIColorMatrix:
            return [.inputRVector, .inputGVector, .inputBVector, .inputAVector, .inputBiasVector]
        case .CIColorPolynomial:
            return [.inputRedCoefficients, .inputGreenCoefficients, .inputBlueCoefficients, .inputAlphaCoefficients]
        case .CITemperatureAndTint:
            return [.inputNeutral, .inputTargetNeutral]
        case .CIToneCurve:
            return [.inputPoint0, .inputPoint1, .inputPoint2, .inputPoint3, .inputPoint4]
        case .CIWhitePointAdjust:
            return [.inputColor]
//        case .CIColorCrossPolynomial:
//            return [.inputRedCoefficientsDeca, .inputGreenCoefficientsDeca, .inputBlueCoefficientsDeca]
        case .CIColorMonochrome:
            return [.inputColor]
        case .CIFalseColor:
            return [.inputColor0, .inputColor1]
        case .CIDroste:
            return [.inputInsetPoint0, .inputInsetPoint1]
        case .CIGlassLozenge, .CIDepthOfField:
            return [.inputPoint0, .inputPoint1]
        case .CIStretchCrop:
            return [.inputSize]
        case .CIPerspectiveCorrection, .CIPerspectiveTransform:
            return [.inputTopLeft, .inputTopRight, .inputBottomLeft, .inputBottomRight]
        case .CISpotLight:
            return [.inputColor, .inputLightPosition, .inputLightPointsAt]
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
    case CIMedianFilter
    case CIMotionBlur
    case CINoiseReduction
    case CIZoomBlur
    case CIColorClamp
    case CIColorControls
    case CIColorMatrix
}

enum FilterParameter: String {
    case inputRadius
    case inputRadius2
    case inputRadius30
    case inputRadius600
    case inputRadius1000
    case inputRadius2000
    case inputAngle
    case inputAngle3
    case inputAngle30
    case inputNoiseLevel
    case inputSharpness
    case inputAmount
    case inputAmount200
    case inputSaturation
    case inputSaturation10
    case inputBrightness
    case inputBrightness10
    case inputContrast
    case inputEV
    case inputPower
    case inputIntensity
    case inputIntensityMinus
    case inputIntensity10
    case inputLevels
    case inputFalloff
    case inputScale
    case inputScale100
    case inputStrands
    case inputPeriodicity
    case inputZoom
    case inputRotation
    case inputRefraction
    case inputCenterStretchAmount
    case inputCropAmount
    case inputWidth
    case inputGCR
    case inputUCR
    case inputUnsharpMaskRadius
    case inputUnsharpMaskIntensity
    case inputHighlightAmount
    case inputShadowAmount
    case inputNRNoiseLevel
    case inputNRSharpness
    case inputEdgeIntensity
    case inputThreshold
    case inputContrast200
    case inputConcentration
    
    var name:String {
        switch self {
        case .inputAmount200:
            return "inputAmount"
        case .inputAngle3, .inputAngle30:
            return "inputAngle"
        case .inputRadius2, .inputRadius30, .inputRadius600, .inputRadius1000, .inputRadius2000:
            return "inputRadius"
        case .inputSaturation10:
            return "inputSaturation"
        case .inputIntensity10, .inputIntensityMinus:
            return "inputIntensity"
        case .inputScale100:
            return "inputScale"
        case .inputContrast200:
            return "inputContrast"
        case .inputBrightness10:
            return "inputBrightness"
        default:
            return self.rawValue
        }
    }
    
    var minimum:NSNumber {
        switch self {
        case .inputAngle:
            return -3.141592653589793
        case .inputAngle3:
            return -12.56637061435917
        case .inputAngle30:
            return -94.24777960769379
        case .inputAmount, .inputBrightness, .inputIntensityMinus, .inputScale, .inputShadowAmount:
            return -1
        case .inputAmount200:
            return -200
        case .inputContrast:
            return 0.25
        case .inputEV:
            return -10
        case .inputPower:
            return 0.25
        case .inputLevels, .inputScale100, .inputPeriodicity:
            return 1
        case .inputStrands:
            return -10
        case .inputZoom:
            return 0.1
        case .inputConcentration:
            return 0.001
        default:
            return 0
        }
    }
    
    var maximum:NSNumber {
        switch self {
        case .inputRadius:
            return 100
        case .inputRadius2:
            return 2
        case .inputRadius30:
            return 30
        case .inputRadius600:
            return 600
        case .inputRadius1000:
            return 1000
        case .inputRadius2000:
            return 2000
        case .inputAngle:
            return 3.141592653589793
        case .inputAngle3:
            return 12.56637061435917
        case .inputAngle30:
            return 94.24777960769379
        case .inputNoiseLevel:
            return 0.1
        case .inputAmount200, .inputEdgeIntensity, .inputWidth, .inputContrast200:
            return 200
        case .inputSaturation, .inputNRSharpness:
            return 2
        case .inputSaturation10, .inputUnsharpMaskRadius, .inputUnsharpMaskIntensity, .inputBrightness10:
            return 10
        case .inputContrast:
            return 4
        case .inputEV:
            return 10
        case .inputPower:
            return 4
        case .inputIntensity10:
            return 10
        case .inputLevels:
            return 30
        case .inputScale100:
            return 100
        case .inputStrands:
            return 10
        case .inputPeriodicity, .inputZoom, .inputRefraction:
            return 5
        case .inputRotation:
            return 6.283185307179586
        case .inputNRNoiseLevel:
            return 0.1
        case .inputConcentration:
            return 1.5
        default:
            return 1
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
    case inputRedCoefficients
    case inputGreenCoefficients
    case inputBlueCoefficients
    case inputAlphaCoefficients
    case inputNeutral
    case inputTargetNeutral
    case inputPoint0
    case inputPoint1
    case inputPoint2
    case inputPoint3
    case inputPoint4
    case inputColor
    case inputColor0
    case inputColor1
    case inputRedCoefficientsDeca
    case inputGreenCoefficientsDeca
    case inputBlueCoefficientsDeca
    case inputInsetPoint0
    case inputInsetPoint1
    case inputSize
    case inputTopLeft
    case inputTopRight
    case inputBottomLeft
    case inputBottomRight
    case inputLightPosition
    case inputLightPointsAt
    
    var name:String {
        switch self {
        case .inputRedCoefficientsDeca:
            return "inputRedCoefficients"
        case .inputGreenCoefficientsDeca:
            return "inputGreenCoefficients"
        case .inputBlueCoefficientsDeca:
            return "inputBlueCoefficients"
        default:
            return self.rawValue
        }
    }
    
    var minimum:[NSNumber] {
        switch self {
        case .inputCenter, .inputInsetPoint0, .inputInsetPoint1, .inputTopLeft, .inputTopRight, .inputBottomLeft, .inputBottomRight:
            return [0, 0]
        case .inputMinComponents:
            return [0, 0, 0, 0]
        case .inputMaxComponents:
            return [0, 0, 0, 0]
        case .inputRVector, .inputGVector, .inputBVector, .inputAVector, .inputBiasVector:
            return [0, 0, 0, 0]
        case .inputRedCoefficients, .inputGreenCoefficients, .inputBlueCoefficients, .inputAlphaCoefficients:
            return [0, 0, 0, 0]
        case .inputNeutral, .inputTargetNeutral:
            return [0, 0]
        case .inputPoint0, .inputPoint1, .inputPoint2, .inputPoint3, .inputPoint4:
            return [0, 0]
        case .inputColor, .inputColor0, .inputColor1:
            return [0, 0, 0, 0]
        case .inputRedCoefficientsDeca, .inputGreenCoefficientsDeca, .inputBlueCoefficientsDeca:
            return [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        case .inputSize:
            return [0, 0]
        case .inputLightPosition, .inputLightPointsAt:
            return [0, 0, 0]
        default:
            return [0, 0]
        }
    }
    
    var maximum:[NSNumber] {
        switch self {
        case .inputCenter, .inputInsetPoint0, .inputInsetPoint1, .inputTopLeft, .inputTopRight, .inputBottomLeft, .inputBottomRight:
            return [1000, 1000]
        case .inputMinComponents:
            return [1, 1, 1, 1]
        case .inputMaxComponents:
            return [1, 1, 1, 1]
        case .inputRVector, .inputGVector, .inputBVector, .inputAVector, .inputBiasVector:
            return [1, 1, 1, 1]
        case .inputRedCoefficients, .inputGreenCoefficients, .inputBlueCoefficients, .inputAlphaCoefficients:
            return [1, 1, 1, 1]
        case .inputNeutral, .inputTargetNeutral:
            return [6500, 6500]
        case .inputPoint0, .inputPoint1, .inputPoint2, .inputPoint3, .inputPoint4:
            return [1, 1]
        case .inputColor, .inputColor0, .inputColor1:
            return [1, 1, 1, 1]
        case .inputRedCoefficientsDeca, .inputGreenCoefficientsDeca, .inputBlueCoefficientsDeca:
            return [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        case .inputSize:
            return [2000, 2000]
        case .inputLightPosition, .inputLightPointsAt:
            return [1000, 1000, 1000]
        default:
            return [0, 0]
        }
    }
}
