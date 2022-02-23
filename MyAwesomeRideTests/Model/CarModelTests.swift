//
//  CarModelTests.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import XCTest
@testable import MyAwesomeRide

class CarModelTests: XCTestCase {
    var sut: [Car]!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MockData.carsData
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testCarsData() {
        XCTAssertNotNil(sut, "Cars data not correct")
        XCTAssert(sut.count == 28, "Cars list count not correct")
        let car = sut[0]
        XCTAssert(car.id == "WMWSW31030T222518", "Cars ID not correct")
        XCTAssert(car.modelName == "MINI", "Car ID not correct")
        XCTAssert(car.name == "Vanessa", "Car Owner name not correct")
        XCTAssert(car.make == "BMW", "Car make not correct")
        XCTAssert(car.color == "midnight_black", "Car color not correct")
        XCTAssert(car.licensePlate == "M-VO0259", "Car license not correct")
        XCTAssert(car.fuelType?.displayTitle == "Diesel", "Car fuel type not correct")
        XCTAssert(car.transmission?.displayTitle == "Manual", "Car transmission not correct")
        XCTAssert(car.innerCleanliness?.displayTitle == "Regular", "Car innerCleanliness not correct")
        XCTAssert(car.latitude == 48.134557, "Car latitude not correct")
        XCTAssert(car.longitude == 11.576921, "Car longitude not correct")
        XCTAssert(car.carImageUrl == "https://cdn.sixt.io/codingtask/images/mini.png", "Car carImageURL not correct")
    }
}
