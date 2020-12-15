//
//  ServiceManager.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 13/12/2020.
//

import Foundation
import Alamofire

class ServiceManager {
    
    // MARK: - Properties
    weak var searchRepositoryDelegate: SearchRepositoryDelegate?
    weak var commitsDetailsDelegate: CommitsDetailsDelegate?
    private var baseURL: String
    
    // MARK: - Initializers
    init() {
        baseURL = "https://api.github.com"
    }
    
    // MARK: - Starting methods
    func searchFor(_ query: String) {
        searchRepositories(query: query)
    }
    
    func getDetailsFor( repository: String, owner: String) {
        getLastCommits(repository: repository, owner: owner)
    }
    
    // MARK: - GitHub API requesting methods
    private func searchRepositories(query: String) {
        let requestURL = baseURL + "/search/repositories?q=" + query
        let queryParameters: [String: Any] = [
            "sort": "stars",
            "order": "desc",
            "per_page": "100"
        ]
        
        AF.request(requestURL, parameters: queryParameters)
          .responseDecodable(of: Repositories.self) { response in
            guard let items = response.value else { return }
            self.searchRepositoryDelegate?.repositoriesLoaded(searchResults: items.items)
          }
    }
    
    private func getLastCommits(repository: String, owner: String) {
        let requestURL = baseURL + "/repos" + "/\(owner)" + "/\(repository)" + "/commits"
        let queryParameters: [String: Any] = [
            "per_page": "3"
        ]
        AF.request(requestURL, parameters: queryParameters)
          .responseDecodable(of: [CommitPreview].self) { response in
            guard let items = response.value else { return }
            self.commitsDetailsDelegate?.commitsDetailsLoaded(commits: items)
          }
    }
}
