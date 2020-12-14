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
    weak var delegate: ServiceManagerDelegate?
    private var searchURL: String
//    private let token: String
    
//    private var repoPreviews: [RepoPreview]?
    
    // MARK: - Initializers
    init() {
        searchURL = "https://api.github.com/search/"
//        token = "9a02f4d070c9359ff50b3bc005d947b7c3e53d73"
    }
    
    // MARK: - Starting methods
    func searchFor(_ query: String) {
        searchRepositories(query: query)
    }
    
    func getDetailsFor() {
        
    }
    
    // MARK: - Requesting methods
    private func searchRepositories(query: String) {
        let requestURL = searchURL + "repositories?q=" + query// + "&token=" + token
        let queryParameters: [String: Any] = [
            "sort": "stars",
            "order": "desc",
            "per_page": "100"
//            "page": "1"
        ]
        
        AF.request(requestURL, parameters: queryParameters)
          .responseDecodable(of: Repositories.self) { response in
            guard let items = response.value else { return }
//            self.repoPreviews = items.items
//            print(response.debugDescription)
//            print("flag1")
//            guard let previews = repoPreviews else { return }
            self.delegate?.serviceManager(searchResults: items.items)
          }
    }
    
    private func getRepoDetails() {
        
    }
}
