//
//  UICollectionDequeue.swift
//  ParallaxOverlayExample
//
//  Created by Marek Fořt on 7/28/19.
//  Copyright © 2019 Marek Fořt. All rights reserved.
//

import UIKit

public protocol Reusable { }

extension Reusable {
    /// Reuse identifier
    public static var reuseIdentifier: String {
        return NSStringFromClass(self as! AnyObject.Type)
    }
}

extension UICollectionViewCell: Reusable {}

extension UICollectionView {
    /// Dequeues `UICollectionViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

