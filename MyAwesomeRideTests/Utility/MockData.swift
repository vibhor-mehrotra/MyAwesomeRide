//
//  MockData.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import Foundation
@testable import MyAwesomeRide

final class MockData {
    static var carsData: [Car]?{
        get{
            do{
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let data = try decoder.decode([Car].self, from: MockData.fetchData(for: "Cars"))
                return data
            } catch {
                return nil
            }
        }
    }
}

extension MockData{
    static func fetchData(for name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: MockData.self)
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}
