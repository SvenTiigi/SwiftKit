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
    
    func testIsProduction() {
        XCTAssertEqual(SwiftKit(executable: FakeExecutable()).environment, SwiftKit.Environment.production)
    }
    
}

struct FakeExecutable: Executable {
    
    func execute(_ command: String) throws -> String {
        return ""
    }
    
    func print(_ text: String) {
        
    }
    
    func print(error: Error) {
        
    }
    
    func readLine(prompt: String?) -> String? {
        return nil
    }
    
    func terminate() {
        
    }

}
