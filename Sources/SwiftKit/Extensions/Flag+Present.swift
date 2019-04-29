//
//  Flag+Present.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 29.04.19.
//

import Foundation
import SwiftCLI

extension Flag {
    
    /// Bool if Flag is present/available
    var isPresent: Bool {
        return self.value == true
    }
    
}
