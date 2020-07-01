//
//  VerticalViewerView5.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/03/25.
//  Copyright © 2019 Domon. All rights reserved.
//

import UIKit

class VerticalViewerView5: VerticalViewerView {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.register(VerticalCell2.self, forCellWithReuseIdentifier: VerticalCell2.className)
            newValue.addGestureRecognizer(self.registerTapGesture(action: #selector(self.didDoubleTap(_:)), numberOfTapsRequired: 2))
            newValue.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(self.didPinch(_:))))
        }
    }
    
    private var zoomScale: CGFloat = 1.0
    
    private var isZoomEnabled: Bool {
        return self.collectionView.minimumZoomScale < self.collectionView.maximumZoomScale
    }
    
    private var data: [(String, CGSize)] = []
    
    override func setData(_ data: [(String, CGSize)]) {
        self.data = data.map { ($0.0, UIScreen.main.sizeFromScreenWidth(with: $0.1)) }
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension VerticalViewerView5: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell2.className, for: indexPath) as! VerticalCell2
        cell.setData(self.data, scale: self.zoomScale)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension VerticalViewerView5: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                                      layout collectionViewLayout: UICollectionViewLayout,
                                      sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = self.data.reduce(0) { height, data in
            return height + data.1.height
        }
        return .init(width: UIScreen.main.bounds.width, height: height * self.zoomScale)
    }
}

extension VerticalViewerView5 {
    
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
        
        if self.zoomScale > self.collectionView.minimumZoomScale {
            self.zoomScale = 1.0
            self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
        } else {
            self.zoomScale = 2.0
            self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
    
    @objc func didPinch(_ sender: UIPinchGestureRecognizer) {
        let scale = max(min(self.collectionView.maximumZoomScale, sender.scale), self.collectionView.minimumZoomScale)
        self.zoomScale = scale
        self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
    }
    
    private func scrollForZoom(center: CGPoint, scale: CGFloat) {
        
    }
}
