//
//  URLSessionDataTaskMock.swift
//  NetworkLayerTests
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation
@testable import NetworkLayer

final class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    
    var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
}
