//
//  RealtimeFilterViewController.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/18.
//  Copyright © 2020 tolv. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SnapKit

class RealtimeFilterViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?

    var photoOutput: AVCapturePhotoOutput?
    var orientation: AVCaptureVideoOrientation = .portrait

    let context = CIContext()

    var filteredImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(filteredImage)
        filteredImage.snp.makeConstraints{make in
//            make.center.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        setupDevice()
        setupInputOutput()
    }

    override func viewDidLayoutSubviews() {
        orientation = AVCaptureVideoOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue)!
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) != .authorized
        {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler:
                { (authorized) in
                    DispatchQueue.main.async
                        {
                            if authorized
                            {
                                self.setupInputOutput()
                            }
                    }
            })
        }
    }

    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices

        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }

        currentCamera = backCamera
    }

    func setupInputOutput() {
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            let videoOutput = AVCaptureVideoDataOutput()

            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            captureSession.startRunning()
        } catch {
            print(error)
        }
    }

    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {
            //see available types
            //print("\(vFormat) \n")

            let ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]

            do {
                //set to 240fps - available types are: 30, 60, 120 and 240 and custom
                // lower framerates cause major stuttering
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    //for custom framerate set min max activeVideoFrameDuration to whatever you like, e.g. 1 and 180
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                print("Could not set active format")
                print(error)
            }
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = orientation
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)

//        let comicEffect = CIFilter(name: "CIComicEffect")

//        guard let CrystallizeFilter = CIFilter(name: "CICrystallize", parameters: ["inputRadius" : 30]) else {return}
        
        guard let blurFilter = CIFilter(name: "CIDiscBlur") else {return}
        blurFilter.setDefaults()

        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvImageBuffer: pixelBuffer!)

        blurFilter.setValue(cameraImage, forKey: kCIInputImageKey)
            
        if let cgImage = self.context.createCGImage(blurFilter.outputImage!, from: cameraImage.extent) {
            DispatchQueue.main.async {
                let filteredImage = UIImage(cgImage: cgImage)
                self.filteredImage.image = filteredImage
            }
        }
    }
}

