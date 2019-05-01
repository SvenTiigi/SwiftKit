//
//  XCTestManifests.swift
//  SwiftKitTests
//
//  Created by Sven Tiigi on 01.05.19.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftKitTests.allTests),
    ]
}
#endif
