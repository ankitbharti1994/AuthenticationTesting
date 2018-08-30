//
//  MockURLProtocol.swift
//  Networking001
//
//  Created by Ankit Kumar Bharti on 28/08/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?, LoginError?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else { return }
        
        do {
            let (response, data, error) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let loginError = error {
                client?.urlProtocol(self, didFailWithError: loginError)
            }else {
                client?.urlProtocol(self, didLoad: data!)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // so something
    }
}
