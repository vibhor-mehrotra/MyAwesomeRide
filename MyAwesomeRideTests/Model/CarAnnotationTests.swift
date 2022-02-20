//
//  CarAnnotationTests.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import XCTest
@testable import MyAwesomeRide
import CoreLocation

class CarAnnotationTests: XCTestCase {
    var sut: CarAnnotation?
    
    override func setUpWithError() throws {
        if let cars = MockData.carsData, cars.count > 0{
            sut = CarAnnotation(with: cars[0])
        }
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testCarAnnotation() throws {
        XCTAssertNotNil(sut, "Cars annotation not correct")
        XCTAssert(sut?.coordinate.latitude == 48.134557, "Car annotation latitude not correct")
        XCTAssert(sut?.coordinate.longitude == 11.576921, "Car annotation longitude not correct")
        XCTAssert(sut?.title == "MINI", "Car annotation title not correct")
        XCTAssert(sut?.subtitle == "M-VO0259", "Car annotation subtitle not correct")
    }
}
