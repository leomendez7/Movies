//
//  UseCasesContainer.swift
//  Movies
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import Domain

final class UseCasesContainer {
    
    class func reloadLoginUseCases() {
        RepositoriesContainer.reloadLoginRepositories()
        UseCasesContainer.fetchMoviesListUseCase = FetchMoviesListUseCase(repository: RepositoriesContainer.fetchMoviesListRepository)
    }
    
    static var fetchMoviesListUseCase = FetchMoviesListUseCase(repository: RepositoriesContainer.fetchMoviesListRepository)
    
}
