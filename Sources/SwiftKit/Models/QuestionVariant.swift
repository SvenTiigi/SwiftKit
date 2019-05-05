//
//  QuestionVariant.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - QuestionVariant

/// The QuestionVariant
enum QuestionVariant: Equatable, Hashable {
    /// Required Question
    case required(text: String)
    /// Optioanl Question
    case optional(
        text: String,
        hint: String,
        defaultAnswer: String
    )
}
