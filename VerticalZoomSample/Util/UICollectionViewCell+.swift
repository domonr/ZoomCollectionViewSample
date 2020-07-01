//
//  UICollectionViewCell+.swift
//  VerticalZoomSample
//
//  Created by Domon on 2020/01/10.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func setupXibForCell(type: Swift.AnyClass) {
        let view = self.loadView(type: type)!
        self.contentView.addSubview(view)
        self.contentView.fitToSelf(childView: view)
    }
}
