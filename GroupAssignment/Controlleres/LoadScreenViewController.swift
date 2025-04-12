import UIKit

class LoadScreenViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(true, forKey: "onBoardingCompleted")

        // Check onboarding flag
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "onBoardingCompleted")

        if hasCompletedOnboarding {
            showMainApp()
        } else {
            showOnboarding()
        }
    }

    private func showMainApp() {
        if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarControllerViewController") as? UITabBarController {
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true)
        }
    }

    private func showOnboarding() {
        if let onboardingVC = storyboard?.instantiateViewController(withIdentifier: "OnBoardingPageViewController") {
            onboardingVC.modalPresentationStyle = .fullScreen
            present(onboardingVC, animated: true)
        }
    }
}
