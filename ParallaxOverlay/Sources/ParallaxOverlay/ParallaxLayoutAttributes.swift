//
//  ParallaxLayoutAttributes.swift
//  
//
//  Created by Marek Fořt on 7/28/19.
//

import UIKit

/**
 Custom class used in `ParallaxLayout`
 */
public class ParallaxLayoutAttributes: UICollectionViewLayoutAttributes {
    /// Coefficient to be used for ofsetting parallax views
    public var parallaxValue: CGFloat = 0

    // MARK: - Life Cycle
    // In life cycle we just copy all needed value using `super` plus our custom attributes
    override public func copy(with zone: NSZone?) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? ParallaxLayoutAttributes else {
            return super.copy(with: zone)
        }

        copiedAttributes.parallaxValue = parallaxValue
        return copiedAttributes
    }

    override public func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? ParallaxLayoutAttributes else { return false }

        if parallaxValue != otherAttributes.parallaxValue {
            return false
        }

        return super.isEqual(object)
    }
}
