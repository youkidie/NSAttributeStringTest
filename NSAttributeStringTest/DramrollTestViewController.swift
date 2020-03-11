//
//  DramrollTestViewController.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/10.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit
import SnapKit

class DramrollTestViewController: UIViewController {
    
    var pickerView = UIPickerView()
    
    var texts:[String] = []
//    var pickerInnerViews:[PickerInnerView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        for i in 0..<10 {
            texts.append(String(i))
            
//            let pickerInnerView = PickerInnerView()
//            pickerInnerView.textField.text = texts[i]
//            pickerInnerView.textField.tag = i
//            pickerInnerView.textField.delegate = self
//            pickerInnerViews.append(pickerInnerView)
        }
        
        self.view.addSubview(pickerView)
        pickerView.snp.makeConstraints{make in
            make.center.equalToSuperview()
            make.height.equalTo(300)
        }
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        tap.delegate = self
        pickerView.addGestureRecognizer(tap)
    }
    
    @objc private func tap(_ gestureRecognizer:UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let rowHeight = self.pickerView.rowSize(forComponent: 0).height
            let selectedRowFrame = self.pickerView.bounds.insetBy(dx: 0.0, dy: (self.pickerView.frame.height - rowHeight) / 2.0 )
            if selectedRowFrame.contains(gestureRecognizer.location(in: self.pickerView)) {
                let selectedRow = self.pickerView.selectedRow(inComponent: 0)
                if let innerView = self.pickerView.view(forRow: selectedRow, forComponent: 0) as? PickerInnerView {
                    if innerView.plusButtonTop.frame.contains(gestureRecognizer.location(in: innerView)) {
                        print(selectedRow)
                        texts.insert("add row \(selectedRow)", at: selectedRow)
                        self.pickerView.reloadAllComponents()
                        self.pickerView.selectRow(selectedRow-1, inComponent: 0, animated: false)
                    }
                    if innerView.textField.frame.contains(gestureRecognizer.location(in: innerView)) {
                        innerView.textField.delegate = self
                        innerView.textField.becomeFirstResponder()
                    }
                    if innerView.plusButtonBottom.frame.contains(gestureRecognizer.location(in: innerView)) {
                        print(selectedRow+1)
                        texts.insert("add row \(selectedRow+1)", at: selectedRow+1)
                        self.pickerView.reloadAllComponents()
                        self.pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
                    }
                }
            }
        }
    }
}

extension DramrollTestViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return texts.count
    }
}

extension DramrollTestViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerInnerView = PickerInnerView()
        pickerInnerView.textField.text = texts[row]
        pickerInnerView.textField.tag = row
        return pickerInnerView
    }
}

extension DramrollTestViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension DramrollTestViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        texts[textField.tag] = textField.text ?? ""
        return true
    }
}

class PickerInnerView:UIView {
    
    let plusButtonTop = UIButton()
    let minuxButton = UIButton()
    let textField = UITextField()
    let plusButtonBottom = UIButton()
    
    init() {
        super.init(frame: .zero)
        
        plusButtonTop.setTitleColor(.black, for: .normal)
        plusButtonTop.setTitle("+++", for: .normal)
        plusButtonTop.backgroundColor = .blue
        addSubview(plusButtonTop)
        plusButtonTop.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().dividedBy(2)
        }
        
        minuxButton.setTitleColor(.black, for: .normal)
        minuxButton.setTitle("---", for: .normal)
        minuxButton.backgroundColor = .red
        addSubview(minuxButton)
        minuxButton.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(self).dividedBy(2)
        }
        
        textField.returnKeyType = .done
        textField.font = UIFont.systemFont(ofSize: 20)
        addSubview(textField)
        textField.snp.makeConstraints{make in
            make.top.equalTo(plusButtonTop.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        plusButtonBottom.setTitleColor(.black, for: .normal)
        plusButtonBottom.setTitle("+++", for: .normal)
        plusButtonBottom.backgroundColor = .blue
        addSubview(plusButtonBottom)
        plusButtonBottom.snp.makeConstraints{make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
//            make.width.equalToSuperview().dividedBy(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
