//
//  VideoFilterExport.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/18.
//  Copyright © 2020 tolv. All rights reserved.
//

import AVFoundation

class VideoFilterExport{
   
    let asset: AVAsset
    let filters: [CIFilter]
    let context: CIContext
    init(asset: AVAsset, filters: [CIFilter], context: CIContext){
        self.asset = asset
        self.filters = filters
        self.context = context
    }
    
    convenience init(asset: AVAsset, filters: [CIFilter]){
        let context:CIContext
        if let device = MTLCreateSystemDefaultDevice() {
            context = CIContext(mtlDevice: device)
        } else {
            context = CIContext()
        }
        self.init(asset: asset, filters: filters, context: context)
    }
    
    func export(toURL url: URL, callback: @escaping (URL?) -> Void){
        guard let track: AVAssetTrack = self.asset.tracks(withMediaType: .video).first else{callback(nil); return}
        
        let composition = AVMutableComposition()
        composition.naturalSize = track.naturalSize
        guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid) else { callback(nil); return }
        guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) else { callback(nil); return }
        
        do{try videoTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: self.asset.duration), of: track, at: CMTime.zero)}
        catch _{callback(nil); return}
        
        if let audio = self.asset.tracks(withMediaType: .audio).first{
            do{try audioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: self.asset.duration), of: audio, at: CMTime.zero)}
            catch _{callback(nil); return}
        }
        
        let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        layerInstruction.trackID = videoTrack.trackID
        
        let instruction = VideoFilterCompositionInstruction(trackID: videoTrack.trackID, filters: self.filters, context: self.context)
        instruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: self.asset.duration)
        instruction.layerInstructions = [layerInstruction]
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.customVideoCompositorClass = VideoFilterCompositor.self
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
        videoComposition.renderSize = videoTrack.naturalSize
        videoComposition.instructions = [instruction]
        
        let session: AVAssetExportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
        session.videoComposition = videoComposition
        session.outputURL = url
        session.outputFileType = .mp4
        
        session.exportAsynchronously(){
            if session.status == AVAssetExportSession.Status.failed {
                print(session.error)
            }
            
            DispatchQueue.main.async{
                callback(url)
            }
        }
    }
}
