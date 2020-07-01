//
//  VerticalCell2.swift
//  VerticalZoomSample
//
//  Created by Domon on 2020/06/29.
//  Copyright © 2020 Domon. All rights reserved.
//

import Foundation
import UIKit
import Nuke

final class VerticalCell2: BaseCollectionViewCell {

    // MARK: - IB

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    private weak var stackViewWidthConstraint: NSLayoutConstraint?
    
    // MARK: - Parameter

    // MARK: - SetData
    
    override func commonInit() {
        super.commonInit()
        self.setupXibForCell(type: VerticalCell2.self)
    }
    
    func setData(_ data: [(String, CGSize)], scale: CGFloat) {
        self.stackViewWidthConstraint?.isActive = false
        self.stackViewWidthConstraint = self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: scale)
        self.stackViewWidthConstraint?.isActive = true
        self.stackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
            self.stackView.removeArrangedSubview(view)
        }
        data.forEach { imgURL, size in
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            Nuke.loadImage(with: URL(string: imgURL)!, into: iv)
            self.stackView.addArrangedSubview(iv)
            iv.heightAnchor.constraint(equalTo: iv.widthAnchor, multiplier: size.height / size.width).isActive = true
            //iv.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * scale).isActive
            //self.scrollView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: scale).isActive = true
        }
    }
}

