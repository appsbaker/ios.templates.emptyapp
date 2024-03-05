//
//  OnboardingFeature.Coordinator.swift
//  Coordinator
//
//  Created by Slava Anishchuk on 21.02.2024.
//

import Platform

extension OnboardingFeature {
    final class Coordinator: BaseCoordinator {
        override func start(animated: Bool, onComplete: FlowCompletion? = nil) {
            self.onComplete = onComplete
            route(to: .welcome)
        }
    }
}

extension OnboardingFeature.Coordinator {
    enum Routes {
        case welcome
    }

    func route(to: Routes, animated: Bool = true) {
        let scene: any FeatureScene
        let factory = OnboardingFeature.SceneFactory(coordinator: self)
        switch to {
        case .welcome:
            scene = factory.onboardingScene()
        }
        navigationController.pushViewController(scene, animated: animated)
    }
}
