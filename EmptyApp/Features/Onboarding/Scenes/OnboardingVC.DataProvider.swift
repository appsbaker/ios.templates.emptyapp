//
//  OnboardingVC.DataProvider.swift
//  AppFeatures
//
//  Created by Slava Anishchuk on 26.02.2024.
//

extension OnboardingVC {
    final class DataProvider {
        static var slides: [OnboardingVC.SlideViewCell.ViewData] {[
            // -- Generated slides --
            .init(title: "Welcome to EmptyApp",
                  imageName: "onboarding.slide1",
                  summary: "This is simple empty application"),
            .init(title: "Finished Slide",
                  imageName: "onboarding.slide2",
                  summary: "This is last slide")
        ]}
    }
}
