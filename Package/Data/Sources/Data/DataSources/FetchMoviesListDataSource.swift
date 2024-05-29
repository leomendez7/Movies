//
//  FetchMoviesListDataSource.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Foundation
import Domain

public class FetchMoviesListDataSource {
    
    let urlBase: String
    
    public init(urlBase: String) {
        self.urlBase = urlBase
    }
    
    public func fetchMoviesList() async throws -> [Movie] {
        let urlString = urlBase
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON String: \(jsonString)")
        }
        let decoder = JSONDecoder()
        do {
            let movieListResponse = try decoder.decode(MovieResponse.self, from: data)
            let sortedMovies = movieListResponse.results.sorted(by: { ($0.popularity ?? 0) > ($1.popularity ?? 0) })
            return sortedMovies
        } catch let decodingError as DecodingError {
            switch decodingError {
            case .typeMismatch(let type, let context):
                print("Tipo '\(type)' no coincide:", context.debugDescription)
                print("Ruta de codificación:", context.codingPath)
            case .valueNotFound(let type, let context):
                print("Valor no encontrado para el tipo '\(type)':", context.debugDescription)
                print("Ruta de codificación:", context.codingPath)
            case .keyNotFound(let key, let context):
                print("Clave '\(key)' no encontrada:", context.debugDescription)
                print("Ruta de codificación:", context.codingPath)
            case .dataCorrupted(let context):
                print("Datos corruptos:", context.debugDescription)
                print("Ruta de codificación:", context.codingPath)
            default:
                print("Error de decodificación:", decodingError.localizedDescription)
            }
            throw decodingError
        } catch {
            print("Error inesperado:", error)
            throw error
        }
    }
    
}
