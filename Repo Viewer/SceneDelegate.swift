//
//  SceneDelegate.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Create the main navigation controller to be used for our app.
        let navController = UINavigationController()
        navController.overrideUserInterfaceStyle = .light
        
        // Send that into our coordinator so that it can display view controllers.
        coordinator = MainCoordinator(navigationController: navController)
        
        // Tell the coordinator to take over control.
        coordinator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

