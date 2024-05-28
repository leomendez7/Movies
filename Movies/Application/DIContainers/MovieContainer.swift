//
//  MovieContainer.swift
//  Movies
//
//  Created by Leonardo Mendez on 28/05/24.
//

import UIKit
import Foundation
import Presentation
import Domain

final class MovieContainer: MoviesListFactory {
    
    static let shared = MovieContainer()
    
    lazy var userCoordinator: MovieFlowCoordinator = {
        return MovieFlowCoordinator(factory: self)
    }()
    
    @objc func updateUseCases(_ notification: NSNotification) {
        UseCasesContainer.reloadLoginUseCases()
    }
    
    private var moviesListViewModel: MoviesListViewModel {
        let coordinator = userCoordinator
        let viewModel = MoviesListViewModel(useCase: UseCasesContainer.fetchMoviesListUseCase,
                              coordinator: coordinator)
        return viewModel
    }
    
    func moviesViewController() -> MoviesViewController {
        let identifier = "Movies"
        let storyBoard = UIStoryboard(name: identifier, bundle: Presentation.bundle)
        let viewController = storyBoard.instantiateViewController(identifier: identifier) { coder in
            return MoviesViewController(viewModel: self.moviesListViewModel, coder: coder)
        }
        return viewController
    }
    
    func movieDetailViewController(movie: Movie) -> MovieDetailViewController {
        let identifier = "MovieDetails"
        let storyBoard = UIStoryboard(name: identifier, bundle: Presentation.bundle)
        let viewController = storyBoard.instantiateViewController(identifier: identifier) { coder in
            return MovieDetailViewController()
        }
        return viewController
    }
    
}
