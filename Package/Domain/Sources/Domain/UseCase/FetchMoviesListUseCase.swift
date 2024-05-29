//
//  FetchMoviesListUseCase.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Foundation

public class FetchMoviesListUseCase: UseCaseProtocol {
    
    let repository: FetchMoviesListRepositoryProtocol
    
    public init(repository: FetchMoviesListRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: Int) async throws -> [Movie] {
        return try await repository.fetchMoviesList(page: requestValue)
    }
    
}
