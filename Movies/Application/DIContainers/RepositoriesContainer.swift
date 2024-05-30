//
//  RepositoriesContainer.swift
//  Movies
//
//  Created by Leonardo Mendez on 28/05/24.
//

import Foundation
import Data
import Domain

final class RepositoriesContainer {
    
    class func reloadLoginRepositories() {
        RepositoriesContainer.fetchMoviesListRepository = FetchMoviesListRepository(datasource: DataSourcesContainer.fetchMoviesListDataSource)
    }
    
    static var fetchMoviesListRepository = FetchMoviesListRepository(datasource: DataSourcesContainer.fetchMoviesListDataSource)
    
}
