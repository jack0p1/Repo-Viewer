//
//  ViewController.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private var serviceManager: ServiceManager?
    private var repoPreviews: [RepoPreview]?
    
    // MARK: - UI Elements
    private lazy var searchBar = UISearchBar()
    private lazy var repoLabel = UILabel()
    private lazy var repoTableView = UITableView()
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = .white
        
        serviceManager = ServiceManager()
        serviceManager?.delegate = self
        serviceManager?.searchFor("alamofire")
        
        setupSearchBar()
        setupRepoLabel()
        setupRepoTableView()
    }

    // MARK: - Setting up the view
    private func setupSearchBar() {
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])
        
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
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
        
        repoTableView.separatorStyle = .none
        repoTableView.dataSource = self
        repoTableView.delegate = self
        repoTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "repoCell")
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
//        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
                
        repoTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 5
        guard let previews = repoPreviews else { return 0 }
        return previews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repoTableView.dequeueReusableCell(withIdentifier: "repoCell") as! RepoTableViewCell
        guard let preview = repoPreviews?[indexPath.section] else {
            return RepoTableViewCell()
        }
        cell.populateCell(repoTitle: preview.repoTitle, thumbnailURL: preview.avatarURL, numberOfStars: preview.numberOfStars)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 9
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.displayRepoDetails()
        repoTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ServiceManagerDelegate
extension SearchViewController: ServiceManagerDelegate {
    func serviceManager(searchResults: [RepoPreview]) {
        repoPreviews = searchResults
        
        repoTableView.reloadData()
    }
    
}

