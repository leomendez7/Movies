//
//  MainController.swift
//  Movies
//
//  Created by Leonardo Mendez on 27/05/24.
//

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRootViewController()
    }
    
    func setupRootViewController() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return }
        let moviesViewController = MovieContainer.shared.moviesViewController()
        window.rootViewController = UINavigationController(rootViewController: moviesViewController)
    }


}

