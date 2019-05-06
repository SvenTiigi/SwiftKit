//
//  FakeExecutable.swift
//  SwiftKitTests
//
//  Created by Sven Tiigi on 06.05.19.
//

import Foundation
import SwiftKit


/// The FakeExecutable
class FakeExecutable {
    
    var executeCommand: String?
    
    var executeReturnValue: String?
    
    var printText: String?
    
    var printErrorText: String?
    
    var isStartLoading: Bool = false
    
    var startLoadingMessage: String?
    
    var isStopLoading: Bool = false
    
    var stopLoadingMessage: String?
    
    var readLinePrompt: String?
    
    var isReadLine: Bool = false
    
    var readLineReturnValue: String?
    
    var isTerminate: Bool = false
    
}

extension FakeExecutable: Executable {
    
    func execute(_ command: String) throws -> String {
        self.executeCommand = command
        return self.executeReturnValue ?? ""
    }
    
    func print(_ text: String) {
        self.printText = text
    }
    
    func printError(_ text: String) {
        self.printErrorText = text
    }
    
    func startLoading(message: String?) {
        self.isStartLoading = true
        self.startLoadingMessage = message
    }
    
    func stopLoading(message: String?) {
        self.isStopLoading = true
        self.stopLoadingMessage = message
    }
    
    func readLine(prompt: String?) -> String? {
        self.isReadLine = true
        self.readLinePrompt = prompt
        return self.readLineReturnValue
    }
    
    func terminate() {
        self.isTerminate = true
    }
    
}
