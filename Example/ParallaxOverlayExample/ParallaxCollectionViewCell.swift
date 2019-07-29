//
//  ParallaxCollectionViewCell.swift
//  ParallaxOverlayExample
//
//  Created by Marek Fořt on 7/28/19.
//  Copyright © 2019 Marek Fořt. All rights reserved.
//

import UIKit
import ParallaxOverlay

class ParallaxCollectionViewCell: UICollectionViewCell {

    var image: UIImage? {
        didSet {
            eventImageView.image = image
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String? {
        didSet {
            infoLabel.text = subtitle
        }
    }

    private enum Constants {
        /// Max value to be offset from normal position
        static let maxHorizontalParallax: CGFloat = 70
        /// Width multiplier of infoStackView
        static let infoStackViewWidthMultiplier: CGFloat = 0.8
    }

    private weak var eventImageView: UIImageView!
    private weak var titleLabel: UILabel!
    private weak var infoLabel: UILabel!
    /// Is between info view and image for background (ears from collection view)
    private weak var cornerMiddleView: UIView!
    private weak var leadingInfoStackViewConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)

        let eventImageView = UIImageView()
        eventImageView.clipsToBounds = true
        eventImageView.contentMode = .scaleAspectFill
        contentView.addSubview(eventImageView)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        eventImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.eventImageView = eventImageView

        /// Is between info view and image for background
        let cornerMiddleView = UIView()
        cornerMiddleView.backgroundColor = .lightWhite
        contentView.addSubview(cornerMiddleView)
        cornerMiddleView.translatesAutoresizingMaskIntoConstraints = false
        cornerMiddleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cornerMiddleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cornerMiddleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cornerMiddleView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        self.cornerMiddleView = cornerMiddleView

        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.layoutMargins = UIEdgeInsets(top: 14, left: 16, bottom: 16, right: 6)
        infoStackView.isLayoutMarginsRelativeArrangement = true
        infoStackView.alignment = .leading
        contentView.addSubview(infoStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        infoStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: Constants.infoStackViewWidthMultiplier).isActive = true
        leadingInfoStackViewConstraint = infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        leadingInfoStackViewConstraint.isActive = true

        let backgroundContentView = UIView()
        backgroundContentView.backgroundColor = .white
        backgroundContentView.layer.cornerRadius = 6
        backgroundContentView.layer.shadowColor = UIColor.black.cgColor
        backgroundContentView.layer.shadowOffset = CGSize(width: 0, height: 6)
        backgroundContentView.layer.shadowRadius = 23
        backgroundContentView.layer.shadowOpacity = 0.1
        backgroundContentView.layer.shadowOffset = CGSize(width: 0, height: 16)
        infoStackView.addSubview(backgroundContentView)
        backgroundContentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundContentView.leadingAnchor.constraint(equalTo: infoStackView.leadingAnchor).isActive = true
        backgroundContentView.trailingAnchor.constraint(equalTo: infoStackView.trailingAnchor).isActive = true
        backgroundContentView.topAnchor.constraint(equalTo: infoStackView.topAnchor).isActive = true
        backgroundContentView.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor).isActive = true

        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        infoStackView.addArrangedSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel = titleLabel

        let subInfoStackView = UIStackView()
        subInfoStackView.spacing = 12
        subInfoStackView.axis = .horizontal
        subInfoStackView.alignment = .center
        infoStackView.addArrangedSubview(subInfoStackView)

        let infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        infoLabel.textColor = .lightGray
        subInfoStackView.addArrangedSubview(infoLabel)
        self.infoLabel = infoLabel

        titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -6).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Applying parallaxValue
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)

        guard let layoutAttributes = layoutAttributes as? ParallaxLayoutAttributes else { return }

        // Default leading offset of infoStackView
        let defaultOffset = contentView.frame.width * ((1 - Constants.infoStackViewWidthMultiplier) / 2)
        leadingInfoStackViewConstraint.constant = layoutAttributes.parallaxValue * Constants.maxHorizontalParallax + defaultOffset
    }
}
