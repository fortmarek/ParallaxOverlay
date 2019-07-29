# ParallaxOverlay
[![CI Status](http://img.shields.io/travis/fortmarek/ParallaxOverlay.svg?style=flat)](https://travis-ci.org/fortmarek/ParallaxOverlay)
[![Version](https://img.shields.io/cocoapods/v/ParallaxOverlay.svg?style=flat)](http://cocoapods.org/pods/ParallaxOverlay)
[![License](https://img.shields.io/cocoapods/l/ParallaxOverlay.svg?style=flat)](http://cocoapods.org/pods/ParallaxOverlay)
<a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
    <a href="https://twitter.com/marekfort">
        <img src="https://img.shields.io/badge/contact-@marekfort-blue.svg?style=flat" alt="Twitter: @marekfort" />
    </a>

![demo](https://github.com/fortmarek/ParallaxOverlay/blob/master/parallax.gif)

ParallaxOverlay is a quick solution if you want parallax for your overlay view in `UICollectionView`.

## Installation

### SPM

`ParallaxOverlay` is available via [Swift Package Manager](https://swift.org/package-manager).

Using Xcode 11, go to `File -> Swift Packages -> Add Package Dependency` and enter [https://github.com/fortmarek/ParallaxOverlay](https://github.com/fortmarek/ParallaxOverlay)  

### CocoaPods

ParallaxOverlay is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ParallaxOverlay'
```

Implementing this is quite easy, firstly, use the provided custom `UICollectionViewFlowLayout`: 
```swift
let parallaxLayout = ParallaxLayout()
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: parallaxLayout)

// Our collection view needs to be bigger than our `view`, otherwise the cells would die when off-screen and our parallax values would just disappear
let collectionViewOverlap: CGFloat = 30
collectionView.contentInset = UIEdgeInsets(top: 0, left: -collectionViewOverlap, bottom: 0, right: collectionViewOverlap)
collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -collectionViewOverlap).isActive = true
collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: collectionViewOverlap).isActive = true
```

Then go to your `UICollectionViewCell` that you use in the `UICollectionView` which you just created and let's implement `func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)` function where we need to specify how to actually apply our parallax: 

```swift
// Applying parallaxValue
override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)

    guard let layoutAttributes = layoutAttributes as? ParallaxLayoutAttributes else { return }

    // Max horizontal parallax from initial position
    let maxHorizontalParallax: CGFloat = 80

    // Default leading offset of infoStackView
    yourParallaxConstraint.constant = layoutAttributes.parallaxValue * maxHorizontalParallax
}
```

In this function we just apply `parallaxValue` to the constraint we would like to move off the axis.

...and we are all set! 🙂 Enjoy 🚀