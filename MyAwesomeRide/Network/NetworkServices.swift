//
//  NetworkServices.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 19/02/22.
//

import Foundation

enum NetworkError: LocalizedError{
    case invalidURL(message: String)
    case noResponse(message: String)
    case invalidResponse(message: String)
    
    var errorDescription: String?{
        switch self{
        case let .invalidURL(message), let .noResponse(message), let .invalidResponse(message):
            return message
        }
    }
}

protocol NetworkServicesProtocol{
    func fetchData(for scheme: String, host: String, path: String, queryParams: [String: String], callBack: @escaping (Result<Data, NetworkError>) -> Void)
}

extension NetworkServicesProtocol{
    func fetchData(for scheme: String = Constants.scheme, host: String, path: String, queryParams: [String: String] = [:], callBack: @escaping (Result<Data, NetworkError>) -> Void){
        fetchData(for: scheme, host: host, path: path, queryParams: queryParams, callBack: callBack)
    }
}

class NetworkServices: NetworkServicesProtocol{
    private var session: URLSession
    
    init(urlSession: URLSession = URLSession.shared){
        self.session = urlSession
    }
    
    func fetchData(for scheme: String, host: String, path: String, queryParams: [String: String], callBack: @escaping (Result<Data, NetworkError>) -> Void){
        guard let url = constructURL(scheme: scheme, host: host, path: path, queryParams: queryParams) else{
            callBack(.failure(.invalidURL(message: "Invalid URL")))
            return
        }
        Task.init{
            await fetchData(url, callBack: callBack)
        }
    }
    
    private func fetchData(_ url: URL, callBack: @escaping (Result<Data, NetworkError>) -> Void) async {
        session.dataTask(with: url) { (data, response, error) -> Void in
            if let _error = error{
                DispatchQueue.main.async {
                    callBack(.failure(.noResponse(message: _error.localizedDescription)))
                }
            } else {
                if let _data = data{
                    DispatchQueue.main.async {
                        callBack(.success(_data))
                    }
                } else{
                    DispatchQueue.main.async {
                        callBack(.failure(.noResponse(message: "Response not in correct format")))
                    }
                }
            }
        }.resume()
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
