//
//  CommitsDetailsDelegate.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 15/12/2020.
//

protocol CommitsDetailsDelegate: AnyObject {
    func commitsDetailsLoaded(commits: [CommitPreview])
}
