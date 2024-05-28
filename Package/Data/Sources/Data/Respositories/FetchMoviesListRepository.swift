//
//  FetchMoviesListRepository.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Foundation
import Domain

public class FetchMoviesListRepository: FetchMoviesListRepositoryProtocol {
    
    let datasource: FetchMoviesListDataSource
    
    public init(datasource: FetchMoviesListDataSource) {
        self.datasource = datasource
    }
    
    public func fetchMoviesList() async throws -> [Movie] {
        return try await datasource.fetchMoviesList()
    }
    
}
