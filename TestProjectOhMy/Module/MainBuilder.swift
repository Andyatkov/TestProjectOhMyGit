//
//  MainBuilder.swift
//  TestProjectOhMy
//
//  Created by ADyatkov on 07.03.2024.
//

import UIKit

enum MainViewBuilder {

    // MARK: - Public methods
    static func build() -> UIViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }

}

