//
//  CustomLayout.swift
//  VerticalZoomSample
//
//  Created by Domon on 2020/06/30.
//  Copyright © 2020 Domon. All rights reserved.
//

import Foundation
import UIKit

final class CustomLayout: UICollectionViewFlowLayout {
    
    var scale: CGFloat = 1.0 {
        didSet {
            guard let collectionView = self.collectionView else { return }
            self.scale = max(min(collectionView.maximumZoomScale, self.scale), collectionView.minimumZoomScale)
        }
    }
    var zoomPoint: CGPoint = .zero
    
    private var attributesArray1: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var attributesArray2: [UICollectionViewLayoutAttributes] = []
    private var delegate: UICollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
    }
    private var contentSize: CGSize = .zero
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override func prepare() {
        self.scrollDirection = .vertical
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        
        guard let collectionView = self.collectionView else { return }
        self.attributesArray1 = [:]
        self.attributesArray2 = []
        var yOffset: CGFloat = 0.0
        let xOffset: CGFloat = collectionView.bounds.width * self.scale
        let sections = collectionView.numberOfSections
        for i in 0..<sections {
            let items = collectionView.numberOfItems(inSection: i)
            for j in 0..<items {
                let indexPath = IndexPath(item: j, section: i)
                let size = self.delegate?.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath).scale(self.scale) ?? .zero
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = .init(origin: .init(x: 0, y: yOffset), size: size)
                self.attributesArray1[indexPath] = attributes
                self.attributesArray2.append(attributes)
                yOffset += size.height
            }
        }
        self.contentSize = .init(width: xOffset, height: yOffset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attributesArray2.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.attributesArray1[indexPath]
    }
    
    private func calcRect(_ rect: CGRect) -> CGRect {
        guard self.zoomPoint != .zero else { return rect }
        let collectionViewSize = self.collectionView?.bounds.size ?? .zero
        let viewableSize = collectionViewSize.scale(1 / self.scale)
        return rect.offsetBy(dx: 0, dy: max(self.zoomPoint.y - viewableSize.height, 0) * self.scale)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard self.zoomPoint != .zero else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
        }
        let collectionViewSize = self.collectionView?.bounds.size ?? .zero
        let viewableSize = collectionViewSize.scale(1 / self.scale)
        let y = proposedContentOffset.y + max(self.zoomPoint.y - viewableSize.height, 0) * self.scale
        let point = CGPoint(x: proposedContentOffset.x, y: y)
        return super.targetContentOffset(forProposedContentOffset: point)
    }
}
