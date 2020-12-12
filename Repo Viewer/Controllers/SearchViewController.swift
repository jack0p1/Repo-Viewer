//
//  ViewController.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    //MARK: Properties
    weak var coordinator: MainCoordinator?
    
    //MARK: UI Elements
    private lazy var searchBar = UISearchBar()
    private lazy var repoLabel = UILabel()
    private lazy var repoTableView = UITableView()
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search"
        
        setupSearchBar()
        setupRepoLabel()
        setupRepoTableView()
    }

    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        
        searchBar.searchBarStyle = UISearchBar.Style.minimal
    }
    
    private func setupRepoLabel() {
        view.addSubview(repoLabel)
        repoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repoLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            repoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        repoLabel.text = "Repositories"
        repoLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    }
    
    private func setupRepoTableView() {
        view.addSubview(repoTableView)
        repoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repoTableView.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 18),
            repoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        repoTableView.separatorInset = .zero
    }

}

extension SearchViewController: UISearchBarDelegate {
    
}

