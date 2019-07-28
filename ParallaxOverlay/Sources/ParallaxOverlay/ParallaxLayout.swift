//
//  ParallaxLayout.swift
//  
//
//  Created by Marek Fořt on 7/28/19.
//

import Foundation
import UIKit

/**
 This class computes parallaxValue coefficient and zIndex for offsetting parallax views in given cell
 - Note: To apply parallaxValue you need to implement `apply(_ layoutAttributes: UICollectionViewLayoutAttributes)`
 */
public class ParallaxLayout: UICollectionViewFlowLayout {

    // Using our class as default for layoutAttributes
    override public class var layoutAttributesClass: AnyClass {
        return ParallaxLayoutAttributes.self
    }

    private var panGestureRecognizer: UIGestureRecognizer?
    private var currentPage: CGFloat = 0

    public override func prepare() {
        super.prepare()

        if collectionView?.panGestureRecognizer != panGestureRecognizer {
            panGestureRecognizer?.addTarget(self, action: #selector(handlePanGesture))
        }
    }

    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        guard let collectionView = collectionView else { return }
        switch sender.state {
        case .began:
            // Page width used for estimating and calculating paging.
            let pageWidth = itemSize.width + minimumLineSpacing

            // Make an estimation of the current page position.
            let approximatePage = collectionView.contentOffset.x / pageWidth

            // Determine the current page based on velocity.
            currentPage = round(abs(approximatePage))
        default:
            break
        }
    }

    // Implementing our own paging
    // Default can not be used because we need to have content inset, so we can keep the cells alive by layouting collectionView outside of screen
    // This is needed because otherwise the parallaxed view would disappear as soon as the cell would disappear from the screen
    // Partly taken from: https://stackoverflow.com/a/49617263/4975152 but modified
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        // Page width used for estimating and calculating paging.
        let pageWidth = itemSize.width + minimumLineSpacing

        // Create custom flickVelocity.
        let flickVelocity = velocity.x

        // If flickVelocity 0, then we want to stay on the same page, otherwise always move just by one page to the left or right
        // Depending on the current velocity
        let flickedPages: CGFloat = flickVelocity == 0 ? 0 : (velocity.x < 0.0) ? -1 : 1

        print(velocity.x)

        // Calculate newHorizontalOffset.
        let newHorizontalOffset = ((currentPage + flickedPages) * pageWidth) - collectionView.contentInset.left

        return CGPoint(x: newHorizontalOffset, y: proposedContentOffset.y)
    }

    // Dynamic layout, we want to recalculate attributes every time user scrolls
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    /**
     Calculates parallax value (coefficient to use for offset of parallax views)
     */
    private func parallaxValue(forAttributes attributes: ParallaxLayoutAttributes) -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        // Current position
        let position: CGFloat = collectionView.contentOffset.x
        // Desired position
        let final: CGFloat = attributes.frame.minX

        let missing: CGFloat = final - position

        // Calculating parallax value -> parallaxValue is 0 when we are at desired position
        let parallaxValue: CGFloat = missing / collectionView.frame.size.width

        return parallaxValue
    }

}

// MARK: - UICollectionView Attributes
extension ParallaxLayout {
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let parallaxAttributes = super.layoutAttributesForItem(at: indexPath) as? ParallaxLayoutAttributes else { return nil }
        parallaxAttributes.parallaxValue = parallaxValue(forAttributes: parallaxAttributes)
        // Start with 0 as currentIndex path -> should be recalculated in `layoutAttributesForElements`
        if indexPath.item == 0 {
            parallaxAttributes.zIndex = 0
        } else {
            parallaxAttributes.zIndex = 1
        }
        return parallaxAttributes
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let parallaxLayoutAttributes = super.layoutAttributesForElements(in: rect) as? [ParallaxLayoutAttributes] else { return nil }
        let visibleLayoutAttributes: [ParallaxLayoutAttributes] = parallaxLayoutAttributes
            // Filter to attributes only in given rect
            .filter { $0.frame.intersects(rect) }
            .map {
                // Update parallax value
                $0.parallaxValue = parallaxValue(forAttributes: $0)
                // Default value
                $0.zIndex = 1
                return $0
            }
        guard let collectionView = collectionView else { return nil }
        // Find attributes of current cell - we are looking for a cell that is the most visible (closest from left to contentOffset)
        // We then set its value to 0, so the views offset from parallax from neighboring cells are not overlapped (they will be higher on the z-axis, since default value is set to 1)
        visibleLayoutAttributes.sorted(by: { abs($0.frame.minX - collectionView.contentOffset.x) < abs($1.frame.minX - collectionView.contentOffset.x)}).first?.zIndex = 0
        return visibleLayoutAttributes
    }
}
