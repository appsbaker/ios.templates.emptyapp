//
//  OnboardingVC.SlideViewCell.swift
//  AppFeatures
//
//  Created by Slava Anishchuk on 24.02.2024.
//

import DesignSystem

extension OnboardingVC {
    final class SlideViewCell: UICollectionViewCell, Identifiable {
        private let imageView: UIImageView = .init()
        private let titleLabel: UILabel = .init(
            font: .boldSystemFont(ofSize: 28), 
            textAlignment: .center
        )

        private let summaryLabel: UILabel = .init(
            font: .systemFont(ofSize: 17),
            textAlignment: .center
        )

        override init(frame: CGRect) {
            super.init(frame: .zero)
            imageView.contentMode = .scaleAspectFit
            contentView.addSubviews([titleLabel, imageView, summaryLabel])
            setupDefaultConstratinsStyle()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupDefaultConstratinsStyle() {
            imageView.snp.makeConstraints {
                $0.height.equalTo(360)
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(Spacings.standard)
            }
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(Spacings.standard)
            }
            summaryLabel.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview().inset(Spacings.standard)
                $0.top.equalTo(titleLabel.snp.bottom).offset(Spacings.standard)
            }
        }
        
        public func configure(with data: ViewData) {
            titleLabel.text = data.title
            summaryLabel.text = data.summary
            imageView.image = .init(named: data.imageName)
        }
    }
}

extension OnboardingVC.SlideViewCell {
    struct ViewData {
        let title: String
        let imageName: String
        let summary: String
    }
}
