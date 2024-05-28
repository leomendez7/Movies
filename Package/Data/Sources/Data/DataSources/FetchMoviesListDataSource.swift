//
//  FetchMoviesListDataSource.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Foundation
import Domain

public class FetchMoviesListDataSource {
    
    public func fetchMoviesList() async throws -> [Movie] {
        let urlString = "https://api.themoviedb.org/4/list/2?api_key=ecd808c2e2821a26fd7b166a9a01bbe8"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        let movieListResponse = try decoder.decode(MovieResponse.self, from: data)
        return movieListResponse.results
    }
    
}
