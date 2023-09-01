//
//  TabBarViewController.swift
//  RickandMorty
//
//  Created by Adriancys Jesus Villegas Toro on 1/9/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        setupVCs()
    }
    
    // MARK: - Methods
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.tintColor = .label
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }

    func setupVCs() {
            viewControllers = [
                createNavController(for: BrowseViewController(), title: NSLocalizedString("Browse", comment: ""), image: UIImage(systemName: "house")!)
            ]
        }

}
