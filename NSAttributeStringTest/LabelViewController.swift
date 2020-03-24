//
//  LabelViewController.swift
//  NSAttributeStringTest
//
//  Created by d.yukimoto on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit
import SnapKit

class LabelViewController: UIViewController {

    let bgV = UIView()
    let label = UILabel()
    let doubleLabel = UILabel()
    let strokeSlider1 = UISlider()
    let slider1ValueLabel = UILabel()
    let strokeSlider2 = UISlider()
    let slider2ValueLabel = UILabel()
    var fontSetButtons:[UIButton] = []
    let sizeSlider = UISlider()
    let sizeLabel = UILabel()
    var decorationButtons:[UIButton] = []
    var colorButtons:[UIButton] = []
    let textField = UITextField()
//    let rotateButton = UIButton()
    
    var fontSet = FontSet.hiraginoKakuGoW8
    var fontDecoration = FontDecoration.color
    var fontColor = FontColorSet.vividBlue
    var fontSize:CGFloat = 30.0
    var text = "テロップ"
    var stroke1:Float = 4.0
    var stroke2:Float = -7.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "dramroll", style: .plain, target: self, action: #selector(moveToDramroll)), animated: false)

        bgV.backgroundColor = .lightGray
        self.view.addSubview(bgV)
        
        self.label.layer.cornerRadius = 10.0
        bgV.addSubview(label)
        bgV.addSubview(doubleLabel)
        
        textField.delegate = self
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.text = text
        self.view.addSubview(textField)
        
        strokeSlider1.value = stroke1/10
        strokeSlider1.addTarget(self, action: #selector(slider1DidChangeValue(_:)), for: .touchUpInside)
        self.view.addSubview(strokeSlider1)
        
        slider1ValueLabel.textColor = .black
        slider1ValueLabel.font = UIFont.systemFont(ofSize: 15)
        slider1ValueLabel.text = String(stroke1)
        self.view.addSubview(slider1ValueLabel)
        
        strokeSlider2.value = -stroke2/10
        strokeSlider2.addTarget(self, action: #selector(slider2DidChangeValue(_:)), for: .touchUpInside)
        self.view.addSubview(strokeSlider2)
        
        slider2ValueLabel.textColor = .black
        slider2ValueLabel.font = UIFont.systemFont(ofSize: 15)
        slider2ValueLabel.text = String(stroke2)
        self.view.addSubview(slider2ValueLabel)
        
        for fontSet in FontSet.allCases {
            let button = UIButton()
            if self.fontSet == fontSet {
                button.backgroundColor = .lightGray
            } else {
                button.backgroundColor = .white
            }
            button.setBackgroundImage(UIImage(named: fontSet.resourceName), for: .normal)
            button.tag = fontSet.rawValue
            button.addTarget(self, action: #selector(fontButtonTap(_:)), for: .touchUpInside)
            fontSetButtons.append(button)
            self.view.addSubview(button)
        }
        
        sizeSlider.maximumValue = 80.0
        sizeSlider.minimumValue = 8.0
        sizeSlider.value = Float(fontSize)
        sizeSlider.addTarget(self, action: #selector(sizeSliderDidChangeValue(_:)), for: .touchUpInside)
        self.view.addSubview(sizeSlider)
        
        sizeLabel.textColor = .black
        sizeLabel.font = UIFont.systemFont(ofSize: 15)
        sizeLabel.text = String(Float(fontSize))
        self.view.addSubview(sizeLabel)
        
        for decoration in FontDecoration.allCases {
            let button = UIButton()
            if self.fontDecoration == decoration {
                button.backgroundColor = .lightGray
            } else {
                button.backgroundColor = .white
            }
            button.setBackgroundImage(UIImage(named: decoration.resourceName), for: .normal)
            button.tag = decoration.rawValue
            button.addTarget(self, action: #selector(decorationButtonTap(_:)), for: .touchUpInside)
            decorationButtons.append(button)
            self.view.addSubview(button)
        }
        
        for color in FontColorSet.allCases {
            let button = UIButton()
            button.layer.borderWidth = 3.0
            if self.fontColor == color {
                button.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                button.layer.borderColor = color.cgColor
            }
            button.backgroundColor = color.uiColor
            button.tag = color.rawValue
            button.addTarget(self, action: #selector(colorButtonTap(_:)), for: .touchUpInside)
            colorButtons.append(button)
            self.view.addSubview(button)
        }
        
//        rotateButton.backgroundColor = .red
//        rotateButton.setTitle("Rotate", for: .normal)
//        self.view.addSubview(rotateButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        bgV.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(self.view.safeAreaInsets.top)
            make.height.equalTo(250)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        label.snp.makeConstraints{make in
            make.center.equalToSuperview()
        }
        
        doubleLabel.snp.makeConstraints{make in
            make.center.equalTo(label.snp.center)
//            make.size.equalTo(label.snp.size)
        }
        
        textField.snp.makeConstraints{make in
            make.top.equalTo(bgV.snp.bottom).offset(5)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(10)
        }
        
        slider1ValueLabel.snp.makeConstraints{make in
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(44)
            make.width.equalTo(45)
            make.top.equalTo(textField.snp.bottom).offset(5)
        }
        
        strokeSlider1.snp.makeConstraints{make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(44)
            make.right.equalTo(slider1ValueLabel.snp.left).offset(-10)
        }
        
        slider2ValueLabel.snp.makeConstraints{make in
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(44)
            make.width.equalTo(45)
            make.top.equalTo(slider1ValueLabel.snp.bottom).offset(5)
        }
        
        strokeSlider2.snp.makeConstraints{make in
            make.top.equalTo(slider1ValueLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(44)
            make.right.equalTo(slider2ValueLabel.snp.left).offset(-10)
        }
        
        let buttonW = 72 * 0.75
        let buttonH = 52 * 0.75
        for (i, button) in fontSetButtons.enumerated() {
            button.snp.makeConstraints{ make in
                make.width.equalTo(buttonW)
                make.height.equalTo(buttonH)
                make.left.equalToSuperview().offset(10 + (i * (Int(buttonW) + 10)))
                make.top.equalTo(strokeSlider2.snp.bottom).offset(5)
            }
        }
        
        sizeLabel.snp.makeConstraints{make in
            make.height.equalTo(44)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(45)
            make.top.equalTo(fontSetButtons[0].snp.bottom).offset(5)
        }
        
        sizeSlider.snp.makeConstraints{make in
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(fontSetButtons[0].snp.bottom).offset(5)
            make.right.equalTo(sizeLabel.snp.left).offset(-10)
        }
        
        for (i, button) in decorationButtons.enumerated() {
            button.snp.makeConstraints{ make in
                make.width.equalTo(buttonW)
                make.height.equalTo(buttonH)
                make.left.equalToSuperview().offset(10 + (i * (Int(buttonW) + 10)))
                make.top.equalTo(sizeSlider.snp.bottom).offset(5)
            }
        }
        
        for (i, button) in colorButtons.enumerated() {
            button.snp.makeConstraints{ make in
                make.width.equalTo(44)
                make.height.equalTo(44)
                make.left.equalToSuperview().offset(10 + ((i%7) * (Int(44) + 10)))
                make.top.equalTo(decorationButtons[0].snp.bottom).offset(5 + Int(Float(i)/7) * 49)
            }
        }
        
//        rotateButton.snp.makeConstraints{make in
//            if let bottomAnc = colorButtons.last?.snp.bottom {
//                make.top.equalTo(bottomAnc).offset(5)
//                make.size.equalTo(44)
//                make.centerX.equalToSuperview()
//            }
//        }
        
        setLabel()
    }
    
    @objc private func slider1DidChangeValue(_ sender:UISlider) {
        stroke1 = round(sender.value*20)
        slider1ValueLabel.text = String(stroke1)
        setLabel()
    }
    
    @objc private func slider2DidChangeValue(_ sender:UISlider) {
        stroke2 = -round(sender.value*10)
        slider2ValueLabel.text = String(stroke2)
        setLabel()
    }
    
    @objc private func fontButtonTap(_ sender:UIButton) {
        fontSet = FontSet(rawValue: sender.tag) ?? .hiraginoKakuGoW8
        for button in fontSetButtons {
            if button == sender {
                button.backgroundColor = .lightGray
            } else {
                button.backgroundColor = .white
            }
        }
        setLabel()
    }
    
    @objc private func sizeSliderDidChangeValue(_ sender:UISlider) {
        fontSize = CGFloat(round(sender.value))
        sizeLabel.text = String(round(sender.value))
        setLabel()
    }
    
    @objc private func decorationButtonTap(_ sender:UIButton) {
        fontDecoration = FontDecoration(rawValue: sender.tag) ?? .color
        for button in decorationButtons {
            if button == sender {
                button.backgroundColor = .lightGray
            } else {
                button.backgroundColor = .white
            }
        }
        setLabel()
    }
    
    @objc private func colorButtonTap(_ sender:UIButton) {
        fontColor = FontColorSet(rawValue: sender.tag) ?? .vividBlue
        for button in colorButtons {
            if button == sender {
                button.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                button.layer.borderColor = button.backgroundColor?.cgColor ?? fontColor.cgColor
            }
        }
        setLabel()
    }
    
//    @objc private func rotateButtonTap(_ sender:UIButton) {
//
//    }
    
    private func setLabel() {
        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 0
        
        self.doubleLabel.alpha = 1.0
        self.label.layer.backgroundColor = nil
        self.label.attributedText = nil
        self.label.text = nil
        self.label.textColor = fontColor.uiColor
        
        switch fontDecoration {
        case .color:
            let textAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(fontSet: fontSet, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
                .paragraphStyle : style,
                .foregroundColor : fontColor.uiColor,
                .strokeColor : fontColor.uiColor,
                .strokeWidth : stroke1
            ]
            let attributedText = NSAttributedString(string: text, attributes: textAttributes)

            self.label.attributedText = attributedText
            
            let textAttributes2: [NSAttributedString.Key : Any] = [
                .font: UIFont(fontSet: fontSet, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
                .paragraphStyle : style,
                .foregroundColor : fontColor.uiColor,
                .strokeColor : fontColor.insideColor,
                .strokeWidth : stroke2
            ]
            let attributedText2 = NSAttributedString(string: text, attributes: textAttributes2)

            self.doubleLabel.attributedText = attributedText2
            
        case .white:
            let textAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(fontSet: fontSet, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
                .paragraphStyle : style,
                .foregroundColor : fontColor.uiColor,
                .strokeColor : fontColor.insideColor,
                .strokeWidth : stroke1
            ]
            let attributedText = NSAttributedString(string: text, attributes: textAttributes)

            self.label.attributedText = attributedText
            
            let textAttributes2: [NSAttributedString.Key : Any] = [
                .font: UIFont(fontSet: fontSet, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
                .paragraphStyle : style,
                .foregroundColor : fontColor.uiColor,
                .strokeColor : fontColor.uiColor,
                .strokeWidth : stroke2
            ]
            let attributedText2 = NSAttributedString(string: text, attributes: textAttributes2)

            self.doubleLabel.attributedText = attributedText2
        case .colorCushion:
            self.doubleLabel.alpha = 0.0
            
            self.label.font = UIFont(fontSet: fontSet, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
            self.label.layer.backgroundColor = fontColor.cgColor
            self.label.textColor = .white
            self.label.text = text
        case .whiteCushion:
            self.doubleLabel.alpha = 0.0
            
            self.label.font = UIFont(fontSet: fontSet, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
            self.label.layer.backgroundColor = UIColor.white.cgColor
            self.label.textColor = fontColor.uiColor
            self.label.text = text
        }
        
        self.label.layer.cornerRadius = 10.0 * (fontSize / 20)
        self.label.sizeToFit()
        self.label.snp.remakeConstraints{make in
            make.center.equalToSuperview()
            make.width.equalTo(self.label.frame.width + 10.0 * (fontSize / 20) * 2)
            make.height.equalTo(self.label.frame.height * 8 / 5)
        }
        self.label.frame.size = CGSize(width: self.label.frame.width + 10.0 * (fontSize / 20) * 2, height: self.label.frame.height * 8 / 5)
        self.label.textAlignment = .center
        
        self.doubleLabel.snp.remakeConstraints{make in
            make.center.equalTo(self.label.snp.center)
            make.size.equalTo(self.label.snp.size)
        }
        self.doubleLabel.frame = self.label.frame
        self.doubleLabel.textAlignment = .center
        
//        print("label \(self.label.frame.origin.x)  \(self.label.frame.origin.y) \(self.label.frame.width) \(self.label.frame.height)")
//        print("doublelabel \(self.doubleLabel.frame.origin.x)  \(self.doubleLabel.frame.origin.y) \(self.doubleLabel.frame.width) \(self.doubleLabel.frame.height)")
    }
}

extension LabelViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.text = textField.text ?? ""
        self.setLabel()
        return true
    }
}
