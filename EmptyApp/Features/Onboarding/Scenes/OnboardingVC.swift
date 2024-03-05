//
//  OnboardingVC.swift
//  Coordinator
//
//  Created by Slava Anishchuk on 21.02.2024.
//

import SnapKit
import Platform
import DesignSystem

final class OnboardingVC: BaseViewController<OnboardingVC.ViewModel> {
    private var subscriptions = Set<AnyCancellable>()
    
    private let bottomStackView: UIStackView = .init()
    private let pageControl: UIPageControl = .init(frame: .zero)
    private let slidePagerView: SlidePagerView = .init()

    private let skipButton: UIButton = .init(
        configuration: .plain(),
        primaryAction: .init(title: "Skip",  handler: { _ in })
    )

    private let nextButton: UIButton = .init(
        configuration: .filled(),
        primaryAction: .init(title: "Next",  handler: { _ in })
    )
    
    private let doneButton: UIButton = .init(
        configuration: .filled(),
        primaryAction: .init(title: "Done",  handler: { _ in })
    )


    override func addActions() {
        nextButton.addAction(
            .init(handler: { [weak self] _ in
                guard let viewModel = self?.viewModel else { return }
                viewModel.action(.next)
            }),
            for: .touchUpInside
        )
        
        skipButton.addAction(
            .init(handler: { [weak self] _ in
                guard let viewModel = self?.viewModel else { return }
                viewModel.action(.skip)
            }),
            for: .touchUpInside
        )
        
        doneButton.addAction(
            .init(handler: { [weak self] _ in
                guard let viewModel = self?.viewModel else { return }
                viewModel.action(.done)
            }),
            for: .touchUpInside
        )
    }

    private func setupSlidePagerView() {
        slidePagerView.delegate = self
        slidePagerView.dataSource = self
        slidePagerView.register(SlideViewCell.self,
                                forCellWithReuseIdentifier: SlideViewCell.identifier)
    }

    private func setupPageControl() {
        pageControl.currentPage = .zero
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.numberOfPages = viewModel?.state.slidesCount ?? .zero
    }

    override func binding() {
        viewModel?.state.$currentPage.sink { [weak self] value in
            self?.pageControl.currentPage = value
            self?.slidePagerView.displaySlide(atIndex: value)
        }
        .store(in: &subscriptions)

        viewModel?.state.$isLastPage.sink(receiveValue: { [weak self] isLastPage in
            self?.skipButton.isHidden = isLastPage
            self?.nextButton.isHidden = isLastPage
            self?.doneButton.isHidden = !isLastPage
        })
        .store(in: &subscriptions)
    }

    override func setupViewAndConstraints() {
        setupPageControl()
        setupSlidePagerView()
        
        let slidePagerHeight: CGFloat = view.bounds.height - Constants.bottomOffset

        view.addSubviews([slidePagerView, pageControl, bottomStackView])
        bottomStackView.addArrangedSubviews([skipButton, nextButton, doneButton])

        slidePagerView.snp.makeConstraints {
            $0.height.equalTo(slidePagerHeight)
            $0.leading.trailing.top.equalToSuperview()
        }

        pageControl.snp.makeConstraints {
            $0.leading.trailing.equalTo(Spacings.standard)
            $0.top.equalTo(slidePagerView.snp.bottom).inset(Spacings.doubleStandard + Spacings.standard)
        }

        bottomStackView.snp.makeConstraints {
            $0.height.equalTo(Constants.bottomBarHeight)
            $0.leading.trailing.equalToSuperview().inset(Spacings.doubleStandard)
            $0.bottom.equalToSuperview().inset(Constants.bottomBarOffset)
        }
    }
}

private extension OnboardingVC {
    enum Constants {
        static let bottomBarHeight: CGFloat = 44
        static let bottomBarOffset: CGFloat = 54
        static let bottomOffset: CGFloat = bottomBarOffset + bottomBarHeight
    }
}
