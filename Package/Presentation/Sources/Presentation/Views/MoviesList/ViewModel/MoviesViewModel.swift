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
    @Published var movies: [Movie] = []
    
    func fetchMovies() async {
        do {
            let movies = try await useCase.execute(requestValue: "")
            self.movies = movies
            reloadData.send()
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
}
