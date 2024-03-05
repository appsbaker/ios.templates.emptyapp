import UIKit
import Platform

final class Application {
    private let window: UIWindow
    public private(set) var tabBarController: UITabBarController = .init()
    public private(set) var navigationController: UINavigationController = .init()
    
    enum AppFeature {
        case onboarding
    }

    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func run() {
        window.rootViewController = navigationController
        run(feature: .onboarding)
    }
    
    func reload() {
        tabBarController = .init()
        navigationController = .init()
        run()
    }
}

// MARK: - Start Application Flow
extension Application {
    private func run(features: [AppFeature]) {
        window.rootViewController = tabBarController
        for _feature in features {
            let navigationController = UINavigationController()
            let feature = FeatureFactory.get(_feature, navigationController)
            feature.start(animated: false)
            tabBarController.addChild(navigationController)
        }
    }

    func run(feature: AppFeature) {
        window.rootViewController = navigationController
        let _feature: any Feature = FeatureFactory.get(.onboarding, navigationController)
        _feature.start(animated: false)
    }
}
