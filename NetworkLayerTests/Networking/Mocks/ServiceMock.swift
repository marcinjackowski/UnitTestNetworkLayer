//
//  ServiceMock.swift
//  NetworkLayerTests
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Quick
import Nimble
@testable import NetworkLayer

enum ServiceMock: ServiceProtocol {
    
    // 1
    case jsonResponseWith200
    case jsonResponseWithURLParametersWith200
    case errorWith400
    case errorWith500
    
    // 2
    var baseURL: URL {
        return URL(string: "https://google.com/")!
    }
    
    // 3
    var path: String {
        return "api"
    }
    
    var method: HTTPMethod {
        switch self {
        case .jsonResponseWith200:
            return .post
        default:
            return .get
        }
    }
    
    // 4
    var task: Task {
        switch self {
        case .jsonResponseWith200:
            return .requestPlain
        default:
            let parameters = ["test": "test"]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return [:]
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .jsonResponseWith200:
            return .json
        default:
            return .url
        }
    }
}
