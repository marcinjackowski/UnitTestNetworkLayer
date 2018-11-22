//
//  URLSessionDatataskProtocol.swift
//  NetworkLayer
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol: class {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
