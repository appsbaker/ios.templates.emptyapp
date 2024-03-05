//
//  OnboardingVC+UICollectionViewDatasource.swift
//  AppFeatures
//
//  Created by Slava Anishchuk on 26.02.2024.
//

import DesignSystem

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.state.slidesCount ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideViewCell.identifier,
                                                          for: indexPath)
        if let data = viewModel?.state.slides[indexPath.row] {
            (viewCell as? SlideViewCell)?.configure(with: data)
        }
        return viewCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        viewModel?.action(.setPageIndex(currentPageIndex))
    }
}
