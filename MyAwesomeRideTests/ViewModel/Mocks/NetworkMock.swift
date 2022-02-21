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
    
    func fetchData(for scheme: String, host: String, path: String, queryParams: [String: String], callBack: @escaping (Result<Data, NetworkError>) -> Void){
        if shouldTestSuccessCase{
            callBack(.success(MockData.fetchData(for: "Cars")))
        } else {
            callBack(.failure(.noResponse(message: "For testing failure case")))
        }
    }
}
