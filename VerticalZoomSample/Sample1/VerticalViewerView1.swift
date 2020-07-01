//
//  VerticalViewerView1.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/03/25.
//  Copyright © 2019 Domon. All rights reserved.
//

import UIKit

class VerticalViewerView: BaseView {
    func setData(_ data: [(String, CGSize)]) {}
}

class VerticalViewerView1: VerticalViewerView {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.className)
            newValue.addGestureRecognizer(self.registerTapGesture(action: #selector(self.didDoubleTap(_:)), numberOfTapsRequired: 2))
        }
    }
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var isZoomEnabled: Bool {
        return self.scrollView.minimumZoomScale < self.scrollView.maximumZoomScale
    }
    
    private var data: [(String, CGSize)] = []
    
    override func setData(_ data: [(String, CGSize)]) {
        self.data = data
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension VerticalViewerView1: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.data[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.className, for: indexPath) as! VerticalCell
        cell.setData(imgURL: data.0)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VerticalViewerView1: UICollectionViewDelegateFlowLayout {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                      layout collectionViewLayout: UICollectionViewLayout,
                                      sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.sizeFromScreenWidth(with: self.data[indexPath.item].1)
    }
}

extension VerticalViewerView1 {
    
    @discardableResult
    open func registerTapGesture(action: Selector,
                                 numberOfTapsRequired: Int = 1,
                                 cancelsTouchesInView: Bool = false) -> UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action: action)
        gesture.numberOfTapsRequired = numberOfTapsRequired
        gesture.cancelsTouchesInView = cancelsTouchesInView
        self.addGestureRecognizer(gesture)
        return gesture
    }
    
    @objc func didDoubleTap(_ sender: UITapGestureRecognizer) {
        guard self.isZoomEnabled else {
            return
        }
        
        if self.scrollView.zoomScale > self.scrollView.minimumZoomScale {
            self.scrollView.setZoomScale(1.0, animated: true)
        } else {
            let point = sender.location(in: self.collectionView)
            let zoomRect = self.zoomRectForScale(scale: 2.0, center: point)
            self.scrollView.zoom(to: zoomRect, animated: true)
        }
    }
    
    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect()
        zoomRect.size.width = self.scrollView.frame.size.width / scale
        zoomRect.size.height = self.scrollView.frame.size.height / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        return zoomRect
    }
}
