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
    var mockNetworkServices: MockNetworkServices!
    var testTableViewDataSourceExpectation: XCTestExpectation!
    var testTableViewDataSourceFailureExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        mockNetworkServices = MockNetworkServices()
        sut = CarListViewModel(networkServices: mockNetworkServices, delegate: self)
        
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        mockNetworkServices = nil
        testTableViewDataSourceExpectation = nil
        testTableViewDataSourceFailureExpectation = nil
    }

    func testNumberOfSections() {
        XCTAssert(sut.numberOfSections() == 1, "Number of sections not correct")
    }
    
    func testNumberOfRowsInSection() {
        testTableViewDataSourceExpectation = expectation(description: "number of rows in section")
        mockNetworkServices.shouldTestSuccessCase = true
        sut.fetchCars()
        wait(for: [testTableViewDataSourceExpectation], timeout: 2.0)
        XCTAssert(sut.numberOfRows(in: 0) == 28, "Number of rows in sections not correct")
    }
    
    func testNumberOfRowsInSectionFailure() {
        testTableViewDataSourceFailureExpectation = expectation(description: "number of rows in section failure case")
        mockNetworkServices.shouldTestSuccessCase = false
        sut.fetchCars()
        wait(for: [testTableViewDataSourceFailureExpectation], timeout: 2.0)
        XCTAssert(sut.numberOfRows(in: 0) == 0, "Number of rows in sections not correct")
    }

    func testDataForRowAtIndexPath() {
        testTableViewDataSourceExpectation = expectation(description: "data for row at indexPath")
        mockNetworkServices.shouldTestSuccessCase = true
        sut.fetchCars()
        wait(for: [testTableViewDataSourceExpectation], timeout: 2.0)
        let dataForFirstCell = sut.dataForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(dataForFirstCell, "dataForFirstCell is nil")
        XCTAssert(dataForFirstCell?.id == "WMWSW31030T222518", "First cell ID not correct")
    }
    
    func testDataForRowAtIndexPathFailure() {
        testTableViewDataSourceFailureExpectation = expectation(description: "data for row at indexPath failure case")
        mockNetworkServices.shouldTestSuccessCase = false
        sut.fetchCars()
        wait(for: [testTableViewDataSourceFailureExpectation], timeout: 2.0)
        let dataForFirstCell = sut.dataForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertNil(dataForFirstCell, "dataForFirstCell is nil")
    }
}

extension CarListViewModelTests: CarDisplayViewModelDelegate{
    func showLoader(){}
    func hideLoader(){}
    func refreshScreen(){
        testTableViewDataSourceExpectation.fulfill()
    }
    func showError(_ error: String){
        testTableViewDataSourceFailureExpectation.fulfill()
    }
}
