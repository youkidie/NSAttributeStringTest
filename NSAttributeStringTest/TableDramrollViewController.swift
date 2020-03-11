//
//  TableDramrollViewController.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/11.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit
import SnapKit

class TableDramrollViewController:UIViewController {
    
    let carousel = iCarousel(frame: .zero)
    
    var texts:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        for i in 0..<10 {
            texts.append(String(i))
        }
        carousel.isVertical = true
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .cylinder
        carousel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addSubview(carousel)
        carousel.snp.makeConstraints{make in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    @objc private func insertTop(_ sender:UIButton) {
        let index = carousel.currentItemIndex
        texts.insert("", at: index)
        carousel.insertItem(at: index, animated: true)
    }
    
    @objc private func insertBottom(_ sender:UIButton) {
        let index = carousel.currentItemIndex + 1
        texts.insert("", at: index)
        carousel.insertItem(at: index, animated: true)
    }
    
    @objc private func remove(_ sender:UIButton) {
        let index = carousel.currentItemIndex
        texts.remove(at: index)
        carousel.removeItem(at: index, animated: true)
    }
}

extension TableDramrollViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .wrap:
            return 0.0
        case .spacing:
            return value * 1.1
        case .visibleItems:
            print("visible items value:\(value)")
            return 3
        case .radius:
            print("radius value:\(value)")
            return value * 1.1
        case .showBackfaces, .fadeRange, .fadeMax, .angle, .arc, .tilt, .count, .fadeMin, .fadeMinAlpha, .offsetMultiplier:
            print("option:\(option) value:\(value)")
            return value
        @unknown default:
            fatalError()
        }
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        print("index did change \(carousel.currentItemIndex)")
    }
}

extension TableDramrollViewController: iCarouselDataSource {
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        if let view = view {
            if let pickerInnerView = view as? PickerInnerView {
//                pickerInnerView.textField.tag = index
                pickerInnerView.textField.text = texts[index]
//                pickerInnerView.textField.delegate = self
            }
            return view
        } else {
            let pickerInnerView = PickerInnerView()
//            pickerInnerView.backgroundColor = .lightGray
            pickerInnerView.frame = CGRect(x: 0, y: 0, width: 350, height: 120)
            pickerInnerView.textField.text = texts[index]
            pickerInnerView.textField.tag = index
            pickerInnerView.textField.delegate = self

            pickerInnerView.plusButtonTop.addTarget(self, action: #selector(insertTop(_:)), for: .touchUpInside)
            
            pickerInnerView.plusButtonBottom.addTarget(self, action: #selector(insertBottom(_:)), for: .touchUpInside)
            
            pickerInnerView.minuxButton.addTarget(self, action: #selector(remove(_:)), for: .touchUpInside)
            
            return pickerInnerView
        }
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return texts.count
    }
}

extension TableDramrollViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        texts[textField.tag] = textField.text ?? ""
        return true
    }
}
