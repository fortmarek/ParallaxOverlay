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
        static let cellHeight: CGFloat = 300
    }

    private let titles: [String] = ["Georgia", "Svaneti", "Ushguli", "Adishi", "Chvabiani"]
    private let subtitles: [String] = ["Mountains", "Village", "Go explore!", "Must see", "Summertime vacation"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1.0)

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
