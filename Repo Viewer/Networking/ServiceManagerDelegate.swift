//
//  ServiceManagerDelegate.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 13/12/2020.
//

import Foundation

protocol ServiceManagerDelegate: AnyObject {
    func serviceManager(searchResults: [RepoPreview])
}
