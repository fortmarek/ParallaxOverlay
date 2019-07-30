//
//  ViewController.swift
//  ParallaxOverlay
//
//  Created by Marek Fořt on 7/28/19.
//  Copyright © 2019 Marek Fořt. All rights reserved.
//

import UIKit
import ParallaxOverlay

class ViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private enum Constants {
        static let collectionParallaxHorizontalOffset: CGFloat = 30
        static let cellHeight: CGFloat = 350
    }

    private let titles: [String] = ["Georgia", "Svaneti", "Ushguli", "Adishi", "Chvabiani"]
    private let subtitles: [String] = ["Mountains", "Village", "Go explore!", "Must see", "Summertime vacation"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightWhite

        let parallaxLayout = ParallaxLayout()
        parallaxLayout.itemSize = CGSize(width: view.frame.width, height: Constants.cellHeight)
        parallaxLayout.scrollDirection = .horizontal
        parallaxLayout.minimumLineSpacing = 0
        parallaxLayout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: parallaxLayout)
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .white
        collectionView.bounces = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Constants.collectionParallaxHorizontalOffset, bottom: 0, right: Constants.collectionParallaxHorizontalOffset)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -Constants.collectionParallaxHorizontalOffset).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.collectionParallaxHorizontalOffset).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: Constants.cellHeight).isActive = true

        let gradientView = GradientView(colors: [UIColor.black.withAlphaComponent(0), UIColor.black.withAlphaComponent(0.6)], startPoint: CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint(x: 0.0, y: 0.0))
        view.addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        let georgiaLabel = UILabel()
        georgiaLabel.text = "🇬🇪"
        georgiaLabel.font = UIFont.systemFont(ofSize: 80)
        georgiaLabel.textAlignment = .center
        view.addSubview(georgiaLabel)
        georgiaLabel.translatesAutoresizingMaskIntoConstraints = false
        georgiaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        georgiaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        georgiaLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30).isActive = true

        let visitLabel = UILabel()
        visitLabel.text = "You should\nvisit Geogia someday!"
        visitLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        visitLabel.textColor = .lightGray
        visitLabel.numberOfLines = 0
        visitLabel.textAlignment = .center
        view.addSubview(visitLabel)
        visitLabel.translatesAutoresizingMaskIntoConstraints = false
        visitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visitLabel.topAnchor.constraint(equalTo: georgiaLabel.bottomAnchor, constant: 20).isActive = true
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ParallaxCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        cell.image = UIImage(named: "img_0\(indexPath.item)")
        cell.title = titles[indexPath.item]
        cell.subtitle = subtitles[indexPath.item]
        return cell
    }
}


extension UIColor {
    static let lightWhite: UIColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1.0)
}
