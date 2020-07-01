//
//  VerticalViewerView7.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/03/25.
//  Copyright © 2019 Domon. All rights reserved.
//

import UIKit

class VerticalViewerView7: VerticalViewerView {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.collectionViewLayout = self.layout
            newValue.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.className)
            newValue.addGestureRecognizer(self.registerTapGesture(action: #selector(self.didDoubleTap(_:)), numberOfTapsRequired: 2))
            newValue.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(self.didPinch(_:))))
        }
    }
    
    private var layout = CustomLayout()
    
    private var data: [(String, CGSize)] = []
    
    override func setData(_ data: [(String, CGSize)]) {
        self.data = data.map { ($0.0, UIScreen.main.sizeFromScreenWidth(with: $0.1)) }
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension VerticalViewerView7: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
extension VerticalViewerView7: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.sizeFromScreenWidth(with: self.data[indexPath.item].1)
    }
}

extension VerticalViewerView7 {
    
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
        self.layout.zoomPoint = sender.location(in: self.collectionView)
        if self.layout.scale > self.collectionView.minimumZoomScale {
            self.layout.scale = 1.0
            self.collectionView.performBatchUpdates({
                self.collectionView.collectionViewLayout.invalidateLayout()
            }, completion: nil)
        } else {
            self.layout.scale = 2.0
            self.collectionView.performBatchUpdates({
                self.collectionView.collectionViewLayout.invalidateLayout()
            }, completion: nil)
        }
    }
    
    @objc func didPinch(_ sender: UIPinchGestureRecognizer) {
        self.layout.zoomPoint = sender.location(in: self.collectionView)
        self.layout.scale = self.layout.scale * sender.scale
        self.collectionView.performBatchUpdates({
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
        sender.scale = 1.0
    }
}
