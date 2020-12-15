//
//  RepoPreview.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 12/12/2020.
//

import UIKit

struct RepoPreview {
    let repoTitle: String
    let avatarURL: String
    let numberOfStars: Int
    let ownerName: String
    let repoURL: String
    
    private enum CodingKeys: String, CodingKey {
        case repoTitle = "name"
        case avatarURL = "avatar_url"
        case numberOfStars = "stargazers_count"
        case owner
        case ownerName = "login"
        case repoURL = "html_url"
    }
}

// MARK: - Decodable
extension RepoPreview: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    repoTitle = try container.decode(String.self, forKey: .repoTitle)
    let owner = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
    ownerName = try owner.decode(String.self, forKey: .ownerName)
    avatarURL = try owner.decode(String.self, forKey: .avatarURL)
    repoURL = try container.decode(String.self, forKey: .repoURL)
    numberOfStars = try container.decode(Int.self, forKey: .numberOfStars)
  }
}
