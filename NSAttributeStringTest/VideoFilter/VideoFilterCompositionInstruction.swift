//
//  VideoFilterCompositionInstruction.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/18.
//  Copyright © 2020 tolv. All rights reserved.
//

import AVFoundation

class VideoFilterCompositionInstruction:AVMutableVideoCompositionInstruction{
    let trackID: CMPersistentTrackID
    let filters: [CIFilter]
    let context: CIContext
    
    override var requiredSourceTrackIDs: [NSValue]{get{return [NSNumber(value: Int(self.trackID))]}}
    override var containsTweening: Bool{get{return false}}
    
    init(trackID: CMPersistentTrackID, filters: [CIFilter], context: CIContext){
        self.trackID = trackID
        self.filters = filters
        self.context = context
        
        super.init()

        self.enablePostProcessing = true
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
