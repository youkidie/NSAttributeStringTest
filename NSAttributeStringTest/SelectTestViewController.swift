//
//  SelectTestViewController.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/19.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit
import SnapKit

class SelectTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Test"
        
        self.view.backgroundColor = .white
        
        for (i, screen) in Screen.allCases.enumerated() {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.tag = screen.rawValue
            button.setTitle(screen.screenName, for: .normal)
            button.addTarget(self, action: #selector(moveToTest(_:)), for: .touchUpInside)
            self.view.addSubview(button)
            button.snp.makeConstraints{make in
                make.height.equalTo(50)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.top.equalToSuperview().offset(100 + 60 * i)
            }
        }
    }
    
    @objc private func moveToTest(_ sender:UIButton) {
        switch Screen(rawValue: sender.tag) {
        case .LabelTest:
            self.navigationController?.pushViewController(LabelViewController(), animated: false)
        case .DramrollTest:
            self.navigationController?.pushViewController(TableDramrollViewController(), animated: false)
        case .VideoFilterTest:
            self.navigationController?.pushViewController(VideoFilterTestViewController(), animated: false)
        case .RealtimeVideoFilterTest:
            self.navigationController?.pushViewController(RealtimeFilterViewController(), animated: false)
        case .none:
            break
        }
    }
}
