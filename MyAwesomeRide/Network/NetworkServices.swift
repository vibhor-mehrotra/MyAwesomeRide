//
//  NetworkServices.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import Foundation

/// Custom Error type for passing Network related errors
enum NetworkError: LocalizedError{
    case invalidURL(message: String)
    case invalidResponse(message: String)
    
    var errorDescription: String?{
        switch self{
        case let .invalidURL(message), let .invalidResponse(message):
            return message
        }
    }
}

/// Protocol to help mock NeteorkServices
protocol NetworkServicesProtocol{
    func fetchData(for scheme: String, host: String, path: String, queryParams: [String: String]) async throws -> Data
}

/// NetworkServicesProtocol extension to provide default implementation for scheme and queryParams
extension NetworkServicesProtocol{
    func fetchData(for scheme: String = Constants.scheme, host: String, path: String, queryParams: [String: String] = [:]) async throws -> Data{
        return try await fetchData(for: scheme, host: host, path: path, queryParams: queryParams)
    }
}

class NetworkServices: NetworkServicesProtocol{
    private var session: URLSession
    
    init(urlSession: URLSession = URLSession.shared){
        self.session = urlSession
    }
    
    func fetchData(for scheme: String, host: String, path: String, queryParams: [String: String]) async throws -> Data{
        guard let url = constructURL(scheme: scheme, host: host, path: path, queryParams: queryParams) else{
            throw NetworkError.invalidURL(message: "Invalid URL")
        }
        do{
            let (data, _) = try await session.data(from: url)
            return data
        } catch {
            throw NetworkError.invalidResponse(message: error.localizedDescription)
        }
    }
}

extension NetworkServices {
    private func constructURL(scheme: String, host: String, path: String, queryParams: [String: String]) -> URL?{
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.setQueryItems(with: queryParams)
        return urlComponents.url
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
