//
//  UIView+.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/11/11.
//

import UIKit

extension UIView {
    
    func fitToSelf(childView: UIView) {
        self.topAnchor.constraint(equalTo: childView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: childView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: childView.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: childView.bottomAnchor).isActive = true
    }
}

// MARK: - Xib
extension UIView {
    
    func loadView(type: Swift.AnyClass) -> UIView? {
        let bundle = Bundle(for: type)
        let nib = UINib(nibName: String(describing: type), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupXib(type: Swift.AnyClass) {
        let view = self.loadView(type: type)!
        self.addSubview(view)
        self.fitToSelf(childView: view)
    }
    
    static var className: String {
        return autoreleasepool { String(describing: self) }
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}

// MARK: - Animation
extension UIView {
    
    func autoLayoutAnimate(withDuration duration: TimeInterval = 0.3,
                           delay: TimeInterval = 0,
                           options: UIView.AnimationOptions = [],
                           setLayoutAction: () -> Void,
                           completion: (() -> Void)? = nil) {
        self.layoutIfNeeded()
        
        setLayoutAction()
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: { self.layoutIfNeeded() },
            completion: { _ in completion?() }
        )
    }
}
