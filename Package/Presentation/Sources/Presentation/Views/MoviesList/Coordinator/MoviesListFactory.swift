//
//  MoviesListFactory.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import Domain

public protocol MoviesListFactory {
    
    func moviesViewController() -> MoviesViewController
    func movieDetailViewController(movie: Movie) -> MovieDetailsViewController
    
}
