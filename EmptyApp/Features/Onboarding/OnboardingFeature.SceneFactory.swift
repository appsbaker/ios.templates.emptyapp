//
//  OnboardingFeature.SceneFactory.swift
//  Coordinator
//
//  Created by Slava Anishchuk on 22.02.2024.
//

import Platform

extension OnboardingFeature {
    final class SceneFactory {
        private let coordinator: OnboardingFeature.Coordinator

        init(coordinator: OnboardingFeature.Coordinator) {
            self.coordinator = coordinator
        }

        func onboardingScene() -> some FeatureScene {
            let scene = OnboardingVC()
            scene.configueTabBarItem(
                title: "Home",
                image: .init(systemName: "house")
            )
            scene.configure(
                viewModel:
                OnboardingVC.ViewModel(
                    coordinator: coordinator
                )
            )
            return scene
        }
    }
}
