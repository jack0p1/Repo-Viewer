//
//  Storyboarded.swift
//  Repo Viewer
//
//  Created by Jacek Kopaczel on 11/12/2020.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
            let fullName = NSStringFromClass(self)
            let className = fullName.components(separatedBy: ".")[1]
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            return storyboard.instantiateViewController(withIdentifier: className) as! Self
        }
}
