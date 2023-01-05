//
//  TabBarController.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 3/1/23.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        navigationItem.hidesBackButton = true
        setupVCs()

    }
    
   
    
    //MARK: - createNavController
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {

        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }

    func setupVCs() {
            viewControllers = [
                
                createNavController(for: CharacterViewController(), title: NSLocalizedString("Character", comment: ""), image: UIImage(systemName: "person")!),
                createNavController(for: LocationViewController(), title: NSLocalizedString("Location", comment: ""), image: UIImage(systemName: "location")!),
                createNavController(for: EpisodesViewController(), title: NSLocalizedString("Episodes", comment: ""), image: UIImage(systemName: "video")!)
            ]
        }
    


}
