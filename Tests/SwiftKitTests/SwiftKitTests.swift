//
//  SwiftKitTests.swift
//  SwiftKitTests
//
//  Created by Sven Tiigi on 01.05.19.
//

import XCTest
@testable import SwiftKit

/// The SwiftKitTests
final class SwiftKitTests: XCTestCase {
    
    static var allTests = [
        ("testIsProduction", testIsProduction),
    ]
    
    lazy var fakeExecutable = FakeExecutable()
    
    lazy var swiftKit = SwiftKit(executable: self.fakeExecutable)
    
    func testIsProduction() {
        XCTAssertEqual(self.swiftKit.environment, .production)
    }
    
}
