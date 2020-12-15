//
//  CommitPreview.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 14/12/2020.
//

struct CommitPreview {
    let authorName: String
    let authorEmailAddress: String
    let commitMessage: String
    
    private enum CodingKeys: String, CodingKey {
        case authorName = "name"
        case authorEmailAddress = "email"
        case commitMessage = "message"
        case commit
        case author
    }
}

// MARK: - Decodable
extension CommitPreview: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let commit = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .commit)
    let author = try commit.nestedContainer(keyedBy: CodingKeys.self, forKey: .author)
    authorName = try author.decode(String.self, forKey: .authorName)
    authorEmailAddress = try author.decode(String.self, forKey: .authorEmailAddress)
    commitMessage = try commit.decode(String.self, forKey: .commitMessage)
  }
}
