//
//  URLSessionMock.swift
//  NetworkLayerTests
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation
@testable import NetworkLayer

final class URLSessionMock: URLSessionProtocol {
    var service: ServiceMock!
    private(set) var isDataTaskCalled = false
    private(set) var lastURL: URL?
    private(set) var isHttpBodyEmpty = true
    private let dataTask: URLSessionDataTaskProtocol
    
    init(dataTask: URLSessionDataTaskProtocol) {
        self.dataTask = dataTask
    }
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        isDataTaskCalled = true
        lastURL = request.url
        isHttpBodyEmpty = request.httpBody == nil

        switch service {
        case .jsonResponseWith200?:
            let model = ModelMock(test: "test")
            let data = try? JSONEncoder().encode(model)
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
            completionHandler(data, response, nil)
        case .errorWith400?:
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 400, httpVersion: nil, headerFields: nil)
            completionHandler(nil, response, nil)
        case .errorWith500?:
            let response = HTTPURLResponse(url: service.baseURL, statusCode: 500, httpVersion: nil, headerFields: nil)
            completionHandler(nil, response, nil)
        default: ()
        }

        return dataTask
    }
}
