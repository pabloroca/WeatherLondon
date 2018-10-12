//
//  MainCoordinator.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit
import PR2StudioSwift

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    var dependencies: DependencyContainer
    var completed: () -> Void
    private let navigationController: UINavigationController

    init(dependencies: DependencyContainer) {
        self.navigationController = dependencies.navigationController
        self.dependencies = dependencies
        self.completed = {}
    }

    func start() -> UINavigationController {
        let viewModel = ForeCastViewModel()
        let viewController = ForeCastViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        return navigationController
    }
}
