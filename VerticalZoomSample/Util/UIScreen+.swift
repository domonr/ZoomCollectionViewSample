//
//  UIScreen+.swift
//  VerticalZoomSample
//
//  Created by Domon on 2020/01/10.
//  Copyright © 2020 Domon. All rights reserved.
//

import UIKit

extension UIScreen {
    
    typealias AspectRatio = CGSize
    
    // 画面幅と縦横比から高さを取得するよ
    func heightFromScreenWidth(with aspectRatio: AspectRatio) -> CGFloat {
        if aspectRatio.width == 0 || aspectRatio.height == 0 {
            return 0
        }
        return round(self.bounds.width * aspectRatio.height / aspectRatio.width)
    }
    
    func sizeFromScreenWidth(with aspectRatio: AspectRatio) -> CGSize {
        if aspectRatio.width == 0 || aspectRatio.height == 0 {
            return .zero
        }
        let height = round(self.bounds.width * aspectRatio.height / aspectRatio.width)
        return .init(width: self.bounds.width, height: height)
    }
}
