import XCTest
import Domain
@testable import Data

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Request handler is not set.")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // Required but not used in this example
    }
}

final class DataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        movieService = MovieService(session: session)
    }
    
    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    var movieService: MovieService!
    
    func testFetchMoviesListSuccess() async throws {
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                       statusCode: 200, httpVersion: nil, headerFields: nil)!
        let jsonData = """
            {
                "results": [
                    {"id": 1, "title": "Movie 1", "popularity": 9.0},
                    {"id": 2, "title": "Movie 2", "popularity": 7.5}
                ]
            }
            """.data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            return (response, jsonData)
        }
        let movies = try await movieService.fetchMoviesList()
        XCTAssertEqual(movies.count, 2)
        XCTAssertEqual(movies.first?.title, "Movie 1")
    }
    
    func testFetchMoviesListBadRequest() async throws {
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                       statusCode: 400, httpVersion: nil, headerFields: nil)!
        
        MockURLProtocol.requestHandler = { request in
            return (response, Data())
        }
        do {
            _ = try await movieService.fetchMoviesList()
            XCTFail("Expected to throw, but did not throw")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
    func testFetchMoviesListDecodingError() async throws {
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                       statusCode: 200, httpVersion: nil, headerFields: nil)!
        let invalidJsonData = "invalid json".data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            return (response, invalidJsonData)
        }
        do {
            _ = try await movieService.fetchMoviesList()
            XCTFail("Expected to throw, but did not throw")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
}

public class MovieService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    public func fetchMoviesList() async throws -> [Movie] {
        let urlString = "https://api.themoviedb.org/4/list/2?api_key=ecd808c2e2821a26fd7b166a9a01bbe8"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await session.data(for: request)
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
