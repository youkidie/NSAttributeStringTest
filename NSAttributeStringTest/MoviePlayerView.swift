//
//  MoviePlayerView.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/18.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit
import AVFoundation

class MoviePlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return self.layer as! AVPlayerLayer
    }
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    func play() {
        if let player = self.player {
            player.play()
        }
    }
    
    func playLoop() {
        if let player = self.player {
            player.seek(to: CMTime.zero)
            player.play()
        }
    }
    
    func setMute(_ on:Bool) {
        if let player = self.player {
            player.isMuted = on
        }
    }
    
    func stop() {
        if let player = self.player {
            player.pause()
            player.seek(to: .zero)
        }
    }
}

