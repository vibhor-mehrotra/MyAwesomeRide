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
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        sut = CarMapViewModel(networkServices: MockNetworkServices(), delegate: self)
        sut.fetchCars()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testMapCentreProperty() throws {
        let mapCentre = sut.mapCentre
        XCTAssertNotNil(mapCentre, "mapCentre not set correctly")
        XCTAssert(mapCentre?.center.latitude == 48.134557, "mapCentre latitude not correct")
        XCTAssert(mapCentre?.center.longitude == 11.576921, "mapCentre longitude not correct")
    }
    
    func testMapAnnotations() throws {
        let annotations = sut.annotations
        XCTAssert(annotations.count == 28, "Car annotations count not correct")
        let firstAnnotation = annotations[0]
        XCTAssert(firstAnnotation.title == "MINI")
        XCTAssert(firstAnnotation.subtitle == "M-VO0259")
        XCTAssert(firstAnnotation.coordinate.latitude == 48.134557)
        XCTAssert(firstAnnotation.coordinate.longitude == 11.576921)
    }
}

extension CarMapViewModelTests: CarDisplayViewModelDelegate{
    func showLoader(){}
    func hideLoader(){}
    func refreshScreen(){}
    func showError(_ error: String){}
}
