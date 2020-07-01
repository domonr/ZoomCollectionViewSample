//
//  VerticalViewerView6.swift
//  VerticalZoomSample
//
//  Created by Domon on 2019/03/25.
//  Copyright © 2019 Domon. All rights reserved.
//

import UIKit

class VerticalViewerView6: VerticalViewerView {
    
    lazy var collectionView: ZoomCollectionView = {
        let layout = ScalingGridLayout(
            itemSize: UIScreen.main.sizeFromScreenWidth(with: CGSize(width: 710, height: 1_006)),
            columns: 18,
            itemSpacing: 0,
            scale: 1.0
        )
        
        let newValue = ZoomCollectionView(
            frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size),
            layout: layout
        )
        
        newValue.collectionView.dataSource = self
        newValue.collectionView.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.className)
        newValue.collectionView.backgroundColor = .white
        
        newValue.scrollView.minimumZoomScale = 1.0
        newValue.scrollView.zoomScale = 1.0
        newValue.scrollView.maximumZoomScale = 4.0
        
        return newValue
    }()
    
    private var data: [(String, CGSize)] = []
    
    override func commonInit() {
        super.commonInit()
        
        self.addSubview(self.collectionView)
        self.fitToSelf(childView: self.collectionView)
    }
    
    override func setData(_ data: [(String, CGSize)]) {
        self.data = data.map { ($0.0, UIScreen.main.sizeFromScreenWidth(with: $0.1)) }
        self.collectionView.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension VerticalViewerView6: UICollectionViewDataSource {
    
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
