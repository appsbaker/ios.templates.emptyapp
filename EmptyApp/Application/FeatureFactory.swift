import UIKit
import Platform

final class FeatureFactory {
    static func get(
        _ feature: Application.AppFeature,
        _ rootController: UINavigationController
    ) -> any Feature {
        switch feature {
            case .onboarding:
                return OnboardingFeature(rootController)
        }
    }
}
