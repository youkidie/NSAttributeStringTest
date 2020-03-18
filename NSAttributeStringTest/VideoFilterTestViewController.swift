//
//  VideoFilterTestViewController.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/18.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import Photos

class VideoFilterTestViewController: UIViewController {
    
    let moviePlayerView = MoviePlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let button = UIButton()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(record(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints{make in
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.view.addSubview(moviePlayerView)
        moviePlayerView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(button.snp.top).offset(-10)
        }
    }
    
    func fnameDocument(basename: String) -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let outputPath = documentsDirectory.appendingPathComponent(basename)
        return outputPath
        
    }
    
    @objc func record(_ sender:UIButton) {
        guard let path = Bundle.main.path(forResource: "grant_porter--towers_of_pfeiffer", ofType: "mp4") else {return}
        let asset = AVAsset(url: URL(fileURLWithPath: path))
//        guard let blurFilter = CIFilter(name: "CIDiscBlur") else {return}
//        blurFilter.setDefaults()
        guard let blurFilter = CIFilter(name: "CICrystallize", parameters: ["inputRadius" : 30]) else {return}
        
        var filters:[CIFilter] = []
        filters.append(blurFilter)
        
        let exporter = VideoFilterExport(asset: asset, filters: filters)
        exporter.export(toURL: fnameDocument(basename: "test1.mp4"), callback: {[weak self] url in
            guard let `self` = self else {return}
            if let `url` = url {
                print("success \(url.absoluteString)")
                
                let avplayer = AVPlayer(url: url)
                avplayer.automaticallyWaitsToMinimizeStalling = false
                self.moviePlayerView.player = avplayer
                self.moviePlayerView.playLoop()
                
                if PHPhotoLibrary.authorizationStatus() != .authorized {
                    PHPhotoLibrary.requestAuthorization { status in
                        if status == .authorized {
                            self.exportPhotoLibrary(url: url)
                        }
                    }
                } else {
                    self.exportPhotoLibrary(url: url)
                }
            } else {
                print("fail")
            }
        })
    }
    
    private func exportPhotoLibrary(url:URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
          }) { (isCompleted, error) in
            if isCompleted {
              // フォトライブラリに書き出し成功
              do {
                try FileManager.default.removeItem(atPath: url.path)
                print("フォトライブラリ書き出し・ファイル削除成功 : \(url.lastPathComponent)")
              }
              catch {
                print("フォトライブラリ書き出し後のファイル削除失敗 : \(url.lastPathComponent)")
              }
            }
            else {
                print("フォトライブラリ書き出し失敗 : \(url.lastPathComponent)")
                print(error)
            }
        }
    }
}
