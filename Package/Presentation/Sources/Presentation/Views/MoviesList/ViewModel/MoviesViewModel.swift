//
//  MoviesListViewModel.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Combine
import Domain

public class MoviesListViewModel: BaseViewModel<FetchMoviesListUseCase, MovieFlowCoordinator> {
    
    var reloadData = PassthroughSubject<Void, Error>()
    var movies: [Movie] = []
    var pages: Int = 1
    var isLoading = false
    var sortedByPopularity = true
    var filteredMovies: [Movie] = []
    private var searchText = ""
    private var originalMovies: [Movie] = []
    
    func fetchMovies() async {
        do {
            let movies = try await useCase.execute(requestValue: self.pages)
            movies.forEach { movie in
                self.movies.append(movie)
            }
            movies.forEach { movie in
                self.originalMovies.append(movie)
            }
            sortedByPopularity ? sortedPopularity() : sortedTopRate()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func sortedPopularity() {
        let sortedMovies = movies.sorted(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) })
        movies.removeAll()
        sortedMovies.forEach { movie in
            movies.append(movie)
        }
        reloadData.send()
    }
    
    func sortedTopRate() {
        let sortedMovies = movies.sorted(by: { ($0.voteAverage ?? 0) > ($1.voteAverage ?? 0) })
        movies.removeAll()
        sortedMovies.forEach { movie in
            movies.append(movie)
        }
        reloadData.send()
    }
    
    func searchMovies(with text: String) {
        searchText = text
        applySearchFilter()
    }
    
    private func applySearchFilter() {
        if searchText.isEmpty {
            movies.removeAll()
            originalMovies.forEach { movie in
                movies.append(movie)
            }
        } else {
            filteredMovies = originalMovies
            movies.removeAll()
            movies = filteredMovies.filter { $0.originalTitle?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        sortedByPopularity ? sortedPopularity() : sortedTopRate()
    }
}
