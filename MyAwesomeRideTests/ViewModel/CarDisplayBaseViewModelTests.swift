//
//  CarDisplayBaseViewModelTests.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import XCTest
@testable import MyAwesomeRide

class CarDisplayBaseViewModelTests: XCTestCase {
    var sut: CarDisplayBaseViewModel!
    var mockNetworkServices: MockNetworkServices!
    var fetchCarsSuccessExpectation: XCTestExpectation!
    var fetchCarsFailureExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkServices = MockNetworkServices()
        sut = CarDisplayBaseViewModel(networkServices: mockNetworkServices, delegate: self)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockNetworkServices = nil
        fetchCarsSuccessExpectation = nil
        fetchCarsFailureExpectation = nil
        sut = nil
    }

    func testFetchCarsSuccess() {
        fetchCarsSuccessExpectation = expectation(description: "Test Fetch cars success expectations")
        mockNetworkServices.shouldTestSuccessCase = true
        sut.fetchCars()
        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(sut.cars)
        XCTAssert(sut.cars?.count == 28, "Cars list count not correct")
    }
    
    func testFetchCarsFailure() {
        fetchCarsFailureExpectation = expectation(description: "Test Fetch cars failure expectations")
        mockNetworkServices.shouldTestSuccessCase = false
        sut.fetchCars()
        waitForExpectations(timeout: 1.0)
        XCTAssertNil(sut.cars)
    }
}

extension CarDisplayBaseViewModelTests: CarDisplayViewModelDelegate{
    func showLoader(){}
    func hideLoader(){}
    
    func refreshScreen(){
        fetchCarsSuccessExpectation.fulfill()
    }
    
    func showError(_ error: String){
        fetchCarsFailureExpectation.fulfill()
        XCTAssert(error == "For testing failure case", "error message not correct")
    }
}
