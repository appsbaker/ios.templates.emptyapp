//
//  OnboardingVC+ViewModel.swift
//  Coordinator
//
//  Created by Slava Anishchuk on 21.02.2024.
//
import Platform

extension OnboardingVC {
    struct ViewModel: StateMachine {
        let state: State = .init()
        private let coordinator: OnboardingFeature.Coordinator
        init(coordinator: OnboardingFeature.Coordinator) {
            self.coordinator = coordinator
        }

        enum Action {
            case next
            case skip
            case done
            case setPageIndex(Int)
        }

        func action(_ action: Action) {
            switch action {
                case .skip, .done:
                    coordinator.complete()
                case .next:
                    if state.slidesCount > (state.currentPage + 1) {
                        state.currentPage += 1
                    }
                    state.isLastPage = state.currentPage >= state.slidesCount - 1
                case let .setPageIndex(index): 
                    state.currentPage = index
            }
            state.isLastPage = state.currentPage >= state.slidesCount - 1
        }
    }
}

extension OnboardingVC.ViewModel {
    final class State: ObservableObject {
        @Published
        var currentPage: Int = 0
        
        @Published
        var isLastPage: Bool = false
        
        var slidesCount: Int { slides.count }
        let slides: [OnboardingVC.SlideViewCell.ViewData] = OnboardingVC.DataProvider.slides
    }
}
