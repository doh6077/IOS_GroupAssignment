//
//  SceneDelegate.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-03-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //create and set onBoardingCompleted
        //set this to true and it will go straight to tabbar view
        //set this to false, and it will go through onboarding screens
        UserDefaults.standard.set(true, forKey: "onBoardingCompleted")
        //control flag
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "onBoardingCompleted")

        let window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if hasCompletedOnboarding {
            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
            window.rootViewController = tabBarVC
        } else {
            let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            window.rootViewController = onboardingVC
        }

        self.window = window
        window.makeKeyAndVisible()
    }

    // Other scene lifecycle methods remain unchanged:
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
