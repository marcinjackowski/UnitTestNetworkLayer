//
//  NetworkResponseMatchers.swift
//  NetworkLayerTests
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//


import Nimble
@testable import NetworkLayer

func beSuccessful<T: Equatable>(with value: T? = nil) -> Predicate<NetworkResponse<T>> {
    return Predicate<NetworkResponse<T>> { actualExpression in
        let message = ExpectationMessage.expectedActualValueTo("be successful")
        
        guard let actualValue = try actualExpression.evaluate() else {
            return PredicateResult(bool: false, message: message.appendedBeNilHint())
        }
        
        switch actualValue {
        case let .success(model):
            guard let value = value else { return PredicateResult(bool: true, message: message) }
            
            return PredicateResult(bool: model == value, message: message)
        case .failure:
            return PredicateResult(bool: false, message: message)
        }
    }
}

func beFailed<T: Equatable>(with error: NetworkError? = nil) -> Predicate<NetworkResponse<T>> {
    return Predicate<NetworkResponse<T>> { actualExpression in
        let message = ExpectationMessage.expectedActualValueTo("be failed")
        
        if let actualValue = try actualExpression.evaluate() {
            guard case let .failure(actualError) = actualValue else { return PredicateResult(bool: false, message: message) }
            
            if let error = error {
                return PredicateResult(bool: actualError == error, message: message)
            } else {
                return PredicateResult(bool: true, message: message)
            }
        } else {
            return PredicateResult(bool: false, message: message.appendedBeNilHint())
        }
    }
}

