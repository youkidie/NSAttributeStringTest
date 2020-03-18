//
//  VideoFilterCompositor.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/18.
//  Copyright © 2020 tolv. All rights reserved.
//

import AVFoundation

class VideoFilterCompositor : NSObject, AVVideoCompositing {
    
    // For Swift 2.*, replace [String : Any] and [String : Any]? with [String : AnyObject] and [String : AnyObject]? respectively
   
    // You may alter the value of kCVPixelBufferPixelFormatTypeKey to fit your needs
    var requiredPixelBufferAttributesForRenderContext: [String : Any] = [
//        kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32BGRA as UInt32),
        kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
//        kCVPixelBufferOpenGLESCompatibilityKey as String : NSNumber(value: true),
        kCVPixelBufferMetalCompatibilityKey as String : true
    ]
    
    // You may alter the value of kCVPixelBufferPixelFormatTypeKey to fit your needs
    var sourcePixelBufferAttributes: [String : Any]? = [
        kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
//        kCVPixelBufferPixelFormatTypeKey as String : NSNumber(value: kCVPixelFormatType_32BGRA as UInt32),
//        kCVPixelBufferOpenGLESCompatibilityKey as String : NSNumber(value: true),
        kCVPixelBufferMetalCompatibilityKey as String : true
    ]
    
    let renderQueue = DispatchQueue(label: "com.cocktail-make.uitest.renderingqueue", attributes: [])
    let renderContextQueue = DispatchQueue(label: "com.cocktail-make.uitest.rendercontextqueue", attributes: [])
    
    var renderContext: AVVideoCompositionRenderContext!
    override init(){
        super.init()
    }
    
    func startRequest(_ request: AVAsynchronousVideoCompositionRequest){
        autoreleasepool(){
            self.renderQueue.sync{
                guard let instruction = request.videoCompositionInstruction as? VideoFilterCompositionInstruction else{
                    request.finish(with: NSError(domain: "cocktail-make.com", code: 760, userInfo: nil))
                    return
                }
                
                let pixels: CVPixelBuffer

                if let frameBuffer = request.sourceFrame(byTrackID: instruction.trackID) {
                    pixels = frameBuffer
                } else if let blankBuffer = renderContext?.newPixelBuffer() {
                    pixels = blankBuffer
                } else {
                    return
                }
//                guard let pixels = request.sourceFrame(byTrackID: instruction.trackID) else{
//                    request.finish(with: NSError(domain: "cocktail-make.com", code: 761, userInfo: nil))
//                    return
//                }
                
                var image = CIImage(cvPixelBuffer: pixels)
                for filter in instruction.filters{
                  filter.setValue(image, forKey: kCIInputImageKey)
                  image = filter.outputImage ?? image
                }
                
                let newBuffer: CVPixelBuffer? = self.renderContext.newPixelBuffer()

                if let buffer = newBuffer{
                    instruction.context.render(image, to: buffer)
                    request.finish(withComposedVideoFrame: buffer)
                }
                else{
                    request.finish(withComposedVideoFrame: pixels)
                }
            }
        }
    }
    
    func renderContextChanged(_ newRenderContext: AVVideoCompositionRenderContext){
        self.renderContextQueue.sync{
            self.renderContext = newRenderContext
        }
    }
}
