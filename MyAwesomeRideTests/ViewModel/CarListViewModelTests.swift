//
//  CarListViewModelTests.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import XCTest
@testable import MyAwesomeRide

class CarListViewModelTests: XCTestCase {
    var sut: CarListViewModel!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        sut = CarListViewModel(networkServices: MockNetworkServices(), delegate: self)
        sut.fetchCars()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testNumberOfSections() throws {
        XCTAssert(sut.numberOfSections() == 1, "Number of sections not correct")
    }
    
    func testNumberOfRowsInSection() throws {
        XCTAssert(sut.numberOfRows(in: 0) == 28, "Number of rows in sections not correct")
    }

    func testDataForRowAtIndexPath() throws {
        let dataForFirstCell = sut.dataForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(dataForFirstCell, "dataForFirstCell is nil")
        XCTAssert(dataForFirstCell?.id == "WMWSW31030T222518", "First cell ID not correct")
    }
}

extension CarListViewModelTests: CarDisplayViewModelDelegate{
    func showLoader(){}
    func hideLoader(){}
    func refreshScreen(){}
    func showError(_ error: String){}
}
