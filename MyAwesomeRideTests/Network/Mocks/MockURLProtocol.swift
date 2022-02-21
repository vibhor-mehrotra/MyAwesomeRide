//
//  MockURLProtocol.swift
//  MyAwesomeRideTests
//
//  Created by Vibhor Mehrotra on 21/02/22.
//

import Foundation

class MockURLProtocol: URLProtocol{
    static var testData = [URL?: Data]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let data = MockURLProtocol.testData[url] {
                self.client?.urlProtocol(self, didLoad: data)
            } else {
                self.client?.urlProtocol(self, didFailWithError: NSError(domain:"", code:500, userInfo:[ NSLocalizedDescriptionKey: "Bad Request"]))
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
