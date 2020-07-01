//
//  VerticalCell.swift
//  VerticalZoomSample
//
//  Created by Domon on 2020/06/29.
//  Copyright © 2020 Domon. All rights reserved.
//

import Foundation
import UIKit
import Nuke

final class VerticalCell: BaseCollectionViewCell {

    // MARK: - IB

    @IBOutlet private weak var imageView: UIImageView!

    // MARK: - Parameter

    // MARK: - SetData
    
    override func commonInit() {
        super.commonInit()
        self.setupXibForCell(type: VerticalCell.self)
    }
    
    func setData(imgURL: String) {
        Nuke.loadImage(with: URL(string: imgURL)!, into: self.imageView)
    }
}

