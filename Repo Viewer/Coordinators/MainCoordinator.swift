//
//  MainCoordinator.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
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
    
    func share(repoName: String, repoURL: String) {
        guard let url = URL(string: repoURL) else { return }
        let items: [Any] = ["Repository name: \(repoName)", url]
        let vc  = UIActivityViewController(activityItems: items, applicationActivities: nil)
        navigationController.present(vc, animated: true, completion: nil)
    }
}
