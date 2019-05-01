//
//  Flag+Present.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI

extension Flag {
    
    /// Bool if Flag is present/available
    var isPresent: Bool {
        return self.value == true
    }
    
}
