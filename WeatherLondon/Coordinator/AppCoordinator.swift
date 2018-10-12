//
//  AppCoordinator.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit
import PR2StudioSwift

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    var dependencies: DependencyContainer

    // child coordinators
    private let mainCoordinator: MainCoordinator

    init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
        mainCoordinator = MainCoordinator(dependencies: dependencies)

        mainCoordinator.completed = { [weak self] in
            guard let strongSelf = self else { return }
            dependencies.keyWindow.rootViewController = strongSelf.start()
        }
    }

    func start() -> UIViewController {
        return mainCoordinator.start()
    }

}
