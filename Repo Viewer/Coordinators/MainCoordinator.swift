//
//  MainCoordinator.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Initializers
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods
    func start() {
        let vc = SearchViewController.instantiate()
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func displayRepoDetails(for repo: RepoPreview) {
        let vc = DetailsViewController.instantiate()
        vc.coordinator = self
        vc.repoPreview = repo
        navigationController.pushViewController(vc, animated: true)
    }
}
