//
//  SceneDelegate.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: - Private methods
    private func setupMainWindow(for scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene), window == nil else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainViewBuilder.build()
        window?.makeKeyAndVisible()
    }

    // MARK: - Public methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupMainWindow(for: scene)
    }


}

