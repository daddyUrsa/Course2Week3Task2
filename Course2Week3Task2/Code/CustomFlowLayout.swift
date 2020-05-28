//
//  CustomFlowLayout.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

protocol PhotoLayoutDelegate: AnyObject {
  var rootView: UIView { get }
}

class CustomFlowLayout: UICollectionViewLayout {
    weak var delegate: PhotoLayoutDelegate!

    var cache: [UICollectionViewLayoutAttributes] = []

    let numberOfColumns = 2
    let cellPadding: CGFloat = 16
    var cellHeight: CGFloat = 300

    var contentHeight: CGFloat = 0
    var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
        return collectionView.bounds.width
    }

    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
      guard let collectionView = collectionView else { return }
      collectionView.frame = UIScreen.main.bounds
      collectionView.contentInset.left = 16
      collectionView.contentInset.right = -16

      guard cache.isEmpty else { return }
      let columnWidth = (contentWidth - (cellPadding * 3)) / 2
      var xOffset: [CGFloat] = []
      for column in 0..<numberOfColumns {
        if column == 0 {
          xOffset.append(CGFloat(column) * columnWidth)
        } else {
          xOffset.append(CGFloat(column) * columnWidth + cellPadding)
        }
      }

      var column = 0
      var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

      for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)

        if item == 0 {
          column = 0
          cellHeight = 300
        } else {
          switch column {
            case 0:
              if yOffset[column] > yOffset[column + 1] {
                column = 1
                cellHeight = 200
              }
            case 1:
              if yOffset[column] > yOffset[column - 1] {
                column = 0
                cellHeight = 200
              } else {
                column = 1
                cellHeight = 200
              }
            default:
              return
          }
        }

        let frame = CGRect(x: xOffset[column],
                           y: yOffset[column],
                           width: columnWidth,
                           height: cellHeight)

        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        cache.append(attributes)

        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + cellHeight + cellPadding
      }
    }

    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }

}
