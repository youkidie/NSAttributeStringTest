//
//  UITableView.swift
//  NSAttributeStringTest
//
//  Created by zdc on 2020/03/24.
//  Copyright © 2020 tolv. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type,
                                                 for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
        // swiftlint:enable force_cast
    }
    
    func deselectAllRows(animated: Bool) {
        guard let selectedIndexPaths = self.indexPathsForSelectedRows else { return }
        for selectedIndexPath in selectedIndexPaths {
            self.deselectRow(at: selectedIndexPath, animated: animated)
            self.delegate?.tableView!(self, didDeselectRowAt: selectedIndexPath)
        }
    }
    
    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow
        {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
    
    func register<T: UITableViewHeaderFooterView>(_ registrableType: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ registrableType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}

