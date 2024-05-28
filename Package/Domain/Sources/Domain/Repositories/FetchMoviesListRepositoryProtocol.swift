//
//  FetchMoviesListRepositoryProtocol.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Foundation

public protocol FetchMoviesListRepositoryProtocol {
    
    func fetchMoviesList() async throws -> [Movie]
    
}
