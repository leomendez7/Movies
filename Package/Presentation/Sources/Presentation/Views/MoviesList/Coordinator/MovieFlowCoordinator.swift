//
//  MovieFlowCoordinator.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import UIKit
import Domain

public enum MovieFlowRoute {
    
    case usersList
    case movieDetails(movie: Movie)
    
}

public class MovieFlowCoordinator: BaseFlowCoordinator {
    
    public var navigationController: UINavigationController?
    public var factory: MoviesListFactory
    
    public init(factory: MoviesListFactory) {
        self.factory = factory
    }
        
    public func navigate(to flowRoute: MovieFlowRoute) {
        switch flowRoute {
        case .usersList:
            showMovieList()
        case .movieDetails(let movie):
            showMovieDetails(movie: movie)
        }
    }
    
    // MARK: - Routes
    
    private func showMovieList() {
    }
    
    private func showMovieDetails(movie: Movie) {
        let movieDetailsViewController = factory.movieDetailViewController(movie: movie)
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
}

extension UIViewController {
    func presentOnRoot(`with` viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
    }
}

