//
//  MovieDetailViewModel.swift
//
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import Domain

public class MovieDetailViewModel: BaseViewModel<FetchMoviesListUseCase, MovieFlowCoordinator> {
    
    public var movie: Movie? = nil
    
}
