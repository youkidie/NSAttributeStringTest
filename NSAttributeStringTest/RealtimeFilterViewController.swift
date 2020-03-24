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
    var textField = UITextField()
    var settingTableView = UITableView()
    
    let videoFilters = VideoFilter.allCases
    var selectedFilter = VideoFilter.CIBoxBlur
    var parameters:[String:Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        filteredImage.contentMode = .scaleAspectFit
        self.view.addSubview(filteredImage)
        filteredImage.snp.makeConstraints{make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(self.view).dividedBy(2)
        }
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneItemButton = UIBarButtonItem(title:"Done", style: .done, target: self, action: #selector(textFieldDone))
        toolbar.setItems([spacelItem, doneItemButton], animated: true)

        textField.inputView = picker
        textField.inputAccessoryView = toolbar
        
        textField.text = selectedFilter.screenName
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints{make in
            make.top.equalTo(filteredImage.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.separatorStyle = .singleLine
        settingTableView.separatorInset = .zero
        settingTableView.separatorColor = .lightGray
        settingTableView.register(FilterSliderCell.self)
        settingTableView.register(VectorFilterSliderCell.self)
        self.view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints{make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
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
        
//        var parameters:[String:NSNumber] = [:]
//        for valueKey in selectedFilter.valueKeys {
//            parameters[valueKey.] =
//        }
        
        guard let filter = CIFilter(name: selectedFilter.screenName, parameters: parameters) else {return}

//        filter.setDefaults()
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvImageBuffer: pixelBuffer!)

        filter.setValue(cameraImage, forKey: kCIInputImageKey)
            
        if let cgImage = self.context.createCGImage(filter.outputImage!, from: cameraImage.extent) {
            DispatchQueue.main.async {
                let filteredImage = UIImage(cgImage: cgImage)
                self.filteredImage.image = filteredImage
            }
        }
    }
    
    @objc func textFieldDone() {
        self.textField.endEditing(true)
        self.settingTableView.reloadData()
    }
}

extension RealtimeFilterViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return videoFilters.count
    }
}

extension RealtimeFilterViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.parameters = [:]
        self.selectedFilter = videoFilters[row]
        self.textField.text = videoFilters[row].screenName
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return videoFilters[row].screenName
    }
}

extension RealtimeFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < selectedFilter.valueKeys.count {
            return 54
        } else {
            return CGFloat(10 + 44 * (selectedFilter.vectorValueKeys[indexPath.row - selectedFilter.valueKeys.count].maximum.count))
        }
    }
}

extension RealtimeFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedFilter.valueKeys.count + selectedFilter.vectorValueKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < selectedFilter.valueKeys.count {
            let cell = tableView.dequeueReusableCell(with: FilterSliderCell.self, for: indexPath)
            let param = selectedFilter.valueKeys[indexPath.row]
            cell.setSliderValue(param)
            cell.slider.tag = indexPath.row
            cell.slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: VectorFilterSliderCell.self, for: indexPath)
            let param = selectedFilter.vectorValueKeys[indexPath.row - selectedFilter.valueKeys.count]
            cell.setSliderValue(param: param)
            for slider in cell.sliders {
                slider.tag = indexPath.row
                slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .touchUpInside)
            }
            return cell
        }
    }
    
    @objc private func sliderDidChangeValue(_ sender:UISlider) {
        let indexPathRow = sender.tag
        if indexPathRow < selectedFilter.valueKeys.count {
            if let cell = self.settingTableView.cellForRow(at: IndexPath(row: indexPathRow, section: 0)) as? FilterSliderCell {
                if cell.slider == sender {
                    cell.valueLabel.text = String(sender.value)
                    
                    let param = selectedFilter.valueKeys[indexPathRow]
                    self.parameters[param.name] = sender.value
                }
            }
        } else {
            if let cell = self.settingTableView.cellForRow(at: IndexPath(row: indexPathRow, section: 0)) as? VectorFilterSliderCell {
                for i in 0..<cell.sliders.count {
                    if sender == cell.sliders[i] {
                        cell.valueLabels[i].text = String(sender.value)
                        
                        let param = selectedFilter.vectorValueKeys[indexPathRow - selectedFilter.valueKeys.count]
                        
                        switch i {
                        case 0:
                            if let vec = self.parameters[param.name] as? CIVector {
                                self.parameters[param.name] = CIVector.init(x: CGFloat(sender.value), y: vec.y, z: vec.z, w: vec.w)
                            } else {
                                self.parameters[param.name] = CIVector.init(x: CGFloat(sender.value), y: 0, z: 0, w: 0)
                            }
                        case 1:
                            if let vec = self.parameters[param.name] as? CIVector {
                                self.parameters[param.name] = CIVector.init(x: vec.x, y: CGFloat(sender.value), z: vec.z, w: vec.w)
                            } else {
                                self.parameters[param.name] = CIVector.init(x: 0, y: CGFloat(sender.value), z: 0, w: 0)
                            }
                        case 2:
                            if let vec = self.parameters[param.name] as? CIVector {
                                self.parameters[param.name] = CIVector.init(x: vec.x, y: vec.y, z: CGFloat(sender.value), w: vec.w)
                            } else {
                                self.parameters[param.name] = CIVector.init(x: 0, y: 0, z: CGFloat(sender.value), w: 0)
                            }
                        case 3:
                            if let vec = self.parameters[param.name] as? CIVector {
                                self.parameters[param.name] = CIVector.init(x: vec.x, y: vec.y, z: vec.z, w: CGFloat(sender.value))
                            } else {
                                self.parameters[param.name] = CIVector.init(x: 0, y: 0, z: 0, w: CGFloat(sender.value))
                            }
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
}

class FilterSliderCell: UITableViewCell {
    lazy var titleLabel = UILabel()
    lazy var slider = UISlider()
    lazy var valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        titleLabel.font = UIFont.systemFont(ofSize: 8)
        titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        valueLabel.font = UIFont.systemFont(ofSize: 8)
        self.addSubview(valueLabel)
        valueLabel.snp.makeConstraints{make in
            make.width.equalTo(40)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        self.addSubview(slider)
        slider.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(valueLabel.snp.left).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSliderValue(_ param: FilterParameter) {
        self.titleLabel.text = param.name
        self.slider.maximumValue = Float(truncating: param.maximum)
        self.slider.minimumValue = Float(truncating: param.minimum)
    }
}

class VectorFilterSliderCell: UITableViewCell {

    lazy var titleLabel = UILabel()
    lazy var sliders:[UISlider] = []
    lazy var valueLabels:[UILabel] = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .white

        titleLabel.font = UIFont.systemFont(ofSize: 8)
        titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.height.equalTo(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSliderValue(param: FilterParameterVector) {
        self.titleLabel.text = param.name
        
        for slider in sliders {
            slider.removeFromSuperview()
        }
        
        for valueLabel in valueLabels {
            valueLabel.removeFromSuperview()
        }
        
        for i in 0..<param.maximum.count {
            let valueLabel = UILabel()
            valueLabel.font = UIFont.systemFont(ofSize: 8)
            self.addSubview(valueLabel)
            valueLabel.snp.makeConstraints{make in
                make.width.equalTo(40)
                make.right.equalToSuperview().offset(-5)
                make.height.equalTo(44)
                make.top.equalTo(titleLabel.snp.bottom).offset(44*i)
            }
            valueLabels.append(valueLabel)
            
            let slider = UISlider()
            slider.tag = i
            self.addSubview(slider)
            slider.snp.makeConstraints{make in
                make.top.equalTo(titleLabel.snp.bottom).offset(44*i)
                make.left.equalToSuperview().offset(10)
                make.right.equalTo(valueLabel.snp.left).offset(-5)
                make.height.equalTo(44)
            }
            
            slider.maximumValue = Float(truncating: param.maximum[i])
            slider.minimumValue = Float(truncating: param.minimum[i])
            sliders.append(slider)
        }
    }
}
