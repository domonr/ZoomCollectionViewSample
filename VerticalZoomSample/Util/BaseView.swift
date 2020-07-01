//
//  BaseView.swift
//  VerticalZoomSample
//
//  Created by Domon on 2017/03/13.
//  Copyright © 2017年 Domon. All rights reserved.
//

import Foundation
import UIKit

protocol LoadableXib {}

extension LoadableXib where Self: UIView {
    
    static func loadXib() -> Self {
        let className = autoreleasepool { String(describing: self) }
        let bundle = Bundle(for: self)
        let nib: UINib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}

extension UIView: LoadableXib {}

class LoadableView: UIView {}

class BaseView: UIView {
    
    // ここに指定した型名のxibファイルをloadします　※overrideして使ってね
    var loadViewType: BaseView.Type? { return nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
        guard let view = self.loadView(type: self.loadViewType ?? type(of: self)) else {
            return
        }
        self.addSubview(view)
        self.fitToSelf(childView: view)
    }
}
