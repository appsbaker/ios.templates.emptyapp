//
//  OnboardingSlideView.swift
//  AppFeatures
//
//  Created by Slava Anishchuk on 26.02.2024.
//

import DesignSystem

extension OnboardingVC {
    final class SlidePagerView: UICollectionView {
        static var layout: UICollectionViewFlowLayout {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = .zero
            layout.minimumLineSpacing = .zero
            layout.scrollDirection = .horizontal
            return layout
        }

        init() {
            super.init(frame: .zero, collectionViewLayout: Self.layout)
            isPagingEnabled = true
            alwaysBounceHorizontal = false
            showsVerticalScrollIndicator = false
            showsHorizontalScrollIndicator = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private var _safeAreaInsets:UIEdgeInsets?
        override var safeAreaInsets:UIEdgeInsets {
            get { _safeAreaInsets ?? super.safeAreaInsets }
            set { _safeAreaInsets = newValue }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = self.frame.size
                setCollectionViewLayout(layout, animated: false)
            }
        }
        
        func displaySlide(atIndex: Int) {
            let indexPath = IndexPath(row: atIndex, section: 0)
            isPagingEnabled = false
            scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            isPagingEnabled = true
        }
    }
}
