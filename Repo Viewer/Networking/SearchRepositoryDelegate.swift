//
//  SearchRepositoryDelegate.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 13/12/2020.
//

protocol SearchRepositoryDelegate: AnyObject {
    func repositoriesLoaded(searchResults: [RepoPreview])
}
