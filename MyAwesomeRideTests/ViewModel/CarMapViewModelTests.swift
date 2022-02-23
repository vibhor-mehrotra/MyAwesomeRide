//
//  CarMapViewModelTests.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import XCTest
@testable import MyAwesomeRide

class CarMapViewModelTests: XCTestCase {
    var sut: CarMapViewModel!
    var mockNetworkServices: MockNetworkServices!
    var testMapDataSourceExpectation: XCTestExpectation!
    var testMapDataSourceExpectationFailure: XCTestExpectation!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        mockNetworkServices = MockNetworkServices()
        sut = CarMapViewModel(networkServices: mockNetworkServices, delegate: self)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        mockNetworkServices = nil
        testMapDataSourceExpectation = nil
        testMapDataSourceExpectationFailure = nil
    }

    func testMapCentreProperty() {
        testMapDataSourceExpectation = expectation(description: "Map centre")
        mockNetworkServices.shouldTestSuccessCase = true
        sut.fetchCars()
        waitForExpectations(timeout: 2.0)
        let mapCentre = sut.mapCentre
        XCTAssertNotNil(mapCentre, "mapCentre not set correctly")
        XCTAssert(mapCentre?.center.latitude == 48.134557, "mapCentre latitude not correct")
        XCTAssert(mapCentre?.center.longitude == 11.576921, "mapCentre longitude not correct")
    }
    
    func testMapCentrePropertyFailure() {
        testMapDataSourceExpectationFailure = expectation(description: "Map centre failure case")
        mockNetworkServices.shouldTestSuccessCase = false
        sut.fetchCars()
        waitForExpectations(timeout: 2.0)
        XCTAssertNil(sut.mapCentre, "mapCentre not set correctly")
    }
    
    func testMapAnnotations() {
        testMapDataSourceExpectation = expectation(description: "Map Annotation")
        mockNetworkServices.shouldTestSuccessCase = true
        sut.fetchCars()
        waitForExpectations(timeout: 2.0)
        let annotations = sut.annotations
        XCTAssert(annotations.count == 28, "Car annotations count not correct")
        let firstAnnotation = annotations[0]
        XCTAssert(firstAnnotation.title == "MINI")
        XCTAssert(firstAnnotation.subtitle == "M-VO0259")
        XCTAssert(firstAnnotation.coordinate.latitude == 48.134557)
        XCTAssert(firstAnnotation.coordinate.longitude == 11.576921)
    }
    
    func testMapAnnotationsFailure() {
        testMapDataSourceExpectationFailure = expectation(description: "Map Annotation failure case")
        mockNetworkServices.shouldTestSuccessCase = false
        sut.fetchCars()
        waitForExpectations(timeout: 2.0)
        XCTAssert(sut.annotations.count == 0, "Car annotations count not correct")
    }
}

extension CarMapViewModelTests: CarDisplayViewModelDelegate{
    func showLoader(){}
    func hideLoader(){}
    func refreshScreen(){
        testMapDataSourceExpectation.fulfill()
    }
    func showError(_ error: String){
        testMapDataSourceExpectationFailure.fulfill()
    }
}
