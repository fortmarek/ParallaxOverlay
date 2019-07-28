//
//  GradientView.swift
//  ParallaxOverlayExample
//
//  Created by Marek Fořt on 7/28/19.
//  Copyright © 2019 Marek Fořt. All rights reserved.
//

import UIKit

class GradientView: UIView {
    var colors: [UIColor] = [] {
        didSet {
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }

    private weak var gradientLayer: CAGradientLayer!

    /**
     Creates a gradient view with colors and axis
     - Parameters:
     - colors: The colors to be used for the gradient.
     - axis: The axis of the gradient: `.vertical` for bottom-to-top gradient, `.horizontal` for left-to-right gradient.
     */
    public init(colors: [UIColor] = [], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer

        gradientLayer.colors = colors.map { $0.cgColor }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
    }
}
