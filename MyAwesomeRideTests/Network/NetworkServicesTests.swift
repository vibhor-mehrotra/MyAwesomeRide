//
//  NetworkServicesTests.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import XCTest
@testable import MyAwesomeRide

class NetworkServicesTests: XCTestCase {
    var networkServices: NetworkServices!
    var mockURLSession: URLSession!
    
    //MARK: Constants
    private let correctURLForTest = "https://test.io/codingtask/cars/?"
    
    override func setUp() {
        MockURLProtocol.testData = [URL(string: correctURLForTest): MockData.fetchData(for: "Cars")]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockURLSession = URLSession(configuration: config)
        networkServices = NetworkServices(urlSession: mockURLSession)
    }

    override func tearDown() {
        networkServices = nil
        mockURLSession = nil
    }
    
    func testAPIServicesSuccess() {
        let successExpectation = expectation(description: "APISuccess success expectation")
        
        networkServices.fetchData(for: "https", host: "test.io", path: "/codingtask/cars/", callBack: { result in
            switch result{
            case .success(let data):
                XCTAssertTrue(!data.isEmpty, "Empty response")
                successExpectation.fulfill()
            case .failure(_):
                XCTFail("APISuccess success case failed")
                successExpectation.fulfill()
            }
        })
        
        wait(for: [successExpectation], timeout: 1.0)
    }
    
    func testAPISuccessFailureWithInvalidID() {
        let invalidIDFailureExpectation = expectation(description: "APISuccess invalid ID failure expectation")
        networkServices.fetchData(for: "https", host: "www.test.com", path: "/badURL/", callBack: { result in
            switch result{
            case .success(_):
                XCTFail("APISuccess failuer test failed")
                invalidIDFailureExpectation.fulfill()
            case .failure(let error):
                switch error{
                case .invalidResponse(_):
                    XCTFail("wrong error type")
                    invalidIDFailureExpectation.fulfill()
                case .invalidURL(_):
                    XCTFail("wrong error type")
                    invalidIDFailureExpectation.fulfill()
                case .noResponse(_):
                    XCTAssertTrue(true)
                    invalidIDFailureExpectation.fulfill()
                }
            }
        })
        
        wait(for: [invalidIDFailureExpectation], timeout: 1.0)
    }
    
    func testAPISuccessFailureWithInvalidURL() {
        let invalidURLFailureExpectation = expectation(description: "APISuccess invalid URL failure expectation")
        
        networkServices.fetchData(for: "https", host: "www.test.com", path: "badURLWithoutSlashes", callBack: { result in
            switch result{
            case .success(_):
                XCTFail("APISuccess bad url failure test failed")
                invalidURLFailureExpectation.fulfill()
            case .failure(let error):
                switch error{
                case .invalidResponse(_):
                   XCTFail("wrong error type")
                    invalidURLFailureExpectation.fulfill()
                case .invalidURL(_):
                   XCTAssertTrue(true)
                    invalidURLFailureExpectation.fulfill()
                case .noResponse(_):
                   XCTFail("wrong error type")
                   invalidURLFailureExpectation.fulfill()
                }
            }
        })
        
        wait(for: [invalidURLFailureExpectation], timeout: 1.0)
    }
}
