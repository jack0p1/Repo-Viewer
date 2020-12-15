//
//  Repositories.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 14/12/2020.
//

// Used for decoding JSON from the GitHub API's response which is returned as a single object with an array of search results.
struct Repositories: Decodable {
    let items: [RepoPreview]
}
