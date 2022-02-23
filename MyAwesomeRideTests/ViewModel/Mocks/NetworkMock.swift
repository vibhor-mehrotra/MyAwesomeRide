//
//  NetworkMock.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import Foundation
@testable import MyAwesomeRide

class MockNetworkServices: NetworkServicesProtocol{
    var shouldTestSuccessCase = true
    
    func fetchData(for scheme: String, host: String, path: String, queryParams: [String: String]) async throws -> Data{
        if shouldTestSuccessCase{
            return MockData.fetchData(for: "Cars")
        } else {
            throw NetworkError.invalidResponse(message: "For testing failure case")
        }
    }
}
