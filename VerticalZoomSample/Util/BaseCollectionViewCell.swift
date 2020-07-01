//
//  BaseCollectionViewCell.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/11/11.
//

import Foundation
import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func commonInit() {
        // NOP
    }
}
