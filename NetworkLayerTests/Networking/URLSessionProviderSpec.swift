//
//  URLSessionProviderSpec.swift
//  NetworkLayerTests
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Quick
import Nimble
@testable import NetworkLayer

final class URLSessionProviderSpec: QuickSpec {
    
    override func spec() {
        var dataTask: URLSessionDataTaskMock!
        var provider: URLSessionProvider!
        var session: URLSessionMock!
        var response: NetworkResponse<ModelMock>!

        beforeEach {
            dataTask = URLSessionDataTaskMock()
            session = URLSessionMock(dataTask: dataTask)
            provider = URLSessionProvider(session: session)
        }
        
        when("Request is called") {
            beforeEach {
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWith200, completion: { _ in })
            }
            
            then("Session should call dataTask") {
                expect(session.isDataTaskCalled).to(beTrue())
            }
            
            then("Request should set proper url") {
                let request = URLRequest(service: ServiceMock.jsonResponseWith200)
                expect(request.url).to(equal(session.lastURL))
            }
            
            then("URLSessionTask should resume") {
                expect(dataTask.isResumeCalled).to(beTrue())
            }
        }
        
        when("Request is called with json response, status code 200") {
            beforeEach {
                session.service = ServiceMock.jsonResponseWith200
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWith200, completion: { networkResponse in response = networkResponse })
            }
            
            then("Should complete with success response") {
                expect(response).to(beSuccessful())
            }
        }
        
        when("Request is called when server is down") {
            beforeEach {
                session.service = ServiceMock.errorWith500
                provider.request(type: ModelMock.self, service: ServiceMock.errorWith500, completion: { networkResponse in response = networkResponse })
            }
            
            then("Should complete with failure response") {
                expect(response).to(beFailed())
            }
        }
        
        when("Request is called with bad request") {
            beforeEach {
                session.service = ServiceMock.errorWith400
                provider.request(type: ModelMock.self, service: ServiceMock.errorWith400, completion: { networkResponse in response = networkResponse })
            }
            
            then("Should complete with failure response") {
                expect(response).to(beFailed())
            }
        }
        
        when("Request is called with json response, URL parameters, status code 200") {
            beforeEach {
                session.service = ServiceMock.jsonResponseWithURLParametersWith200
                provider.request(type: ModelMock.self, service: ServiceMock.jsonResponseWithURLParametersWith200, completion: { networkResponse in response = networkResponse })
            }
            
            then("HttpBody shoud be empty") {
                expect(session.isHttpBodyEmpty).to(beTrue())
            }
            
            then("URL should contains parameters") {
                let urlComponents = URLComponents(service: ServiceMock.jsonResponseWithURLParametersWith200)
                expect(session.lastURL).to(equal(urlComponents.url))
                expect(session.lastURL?.absoluteString).to(contain("test"))
            }
            
            then("Should complete with success response") {
                expect(response).to(beSuccessful())
            }
            
            then("Should return model") {
                expect(response).to(beSuccessful(with: ModelMock(test: "test")))
            }
        }
    }
}
