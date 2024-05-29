import XCTest
@testable import Domain

class FetchMoviesListRepositoryMock: FetchMoviesListRepositoryProtocol {
    var fetchMoviesListResult: Result<[Movie], Error>!
    
    func fetchMoviesList(page: Int) async throws -> [Movie] {
        switch fetchMoviesListResult {
        case .success(let movies):
            return movies
        case .failure(let error):
            throw error
        case .none:
            fatalError("fetchMoviesListResult must be set before calling fetchMoviesList")
        }
    }
}

final class DomainTests: XCTestCase {
    
    var repositoryMock: FetchMoviesListRepositoryMock!
    var fetchMoviesListUseCase: FetchMoviesListUseCase!
    
    override func setUp() {
        super.setUp()
        repositoryMock = FetchMoviesListRepositoryMock()
        fetchMoviesListUseCase = FetchMoviesListUseCase(repository: repositoryMock)
    }
    
    override func tearDown() {
        repositoryMock = nil
        fetchMoviesListUseCase = nil
        super.tearDown()
    }
    
    func testFetchMoviesListSuccess() async {
        let movies = [
            Movie(backdropPath: "/path1.jpg", id: 1, originalTitle: "Title 1", overview: "Overview 1", posterPath: "/poster1.jpg", mediaType: .movie, adult: false, title: "Title 1", originalLanguage: "en", genreIDS: [1, 2], popularity: 8.0, releaseDate: "2024-01-01", video: false, voteAverage: 7.0, voteCount: 100),
            Movie(backdropPath: "/path2.jpg", id: 2, originalTitle: "Title 2", overview: "Overview 2", posterPath: "/poster2.jpg", mediaType: .movie, adult: false, title: "Title 2", originalLanguage: "en", genreIDS: [1, 2], popularity: 8.5, releaseDate: "2024-02-01", video: false, voteAverage: 7.5, voteCount: 150)
        ]
        repositoryMock.fetchMoviesListResult = .success(movies)
        do {
            let result = try await fetchMoviesListUseCase.execute(requestValue: 1)
            XCTAssertEqual(result.count, movies.count)
            XCTAssertEqual(result[0].id, movies[0].id)
            XCTAssertEqual(result[1].id, movies[1].id)
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    func testFetchMoviesListFailure() async {
        let expectedError = NSError(domain: "Test", code: 1, userInfo: nil)
        repositoryMock.fetchMoviesListResult = .failure(expectedError)
        do {
            _ = try await fetchMoviesListUseCase.execute(requestValue: 1)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}
