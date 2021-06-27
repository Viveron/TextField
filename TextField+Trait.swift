//
//  TextField+Trait.swift
//  TextField
//
//  Created by Viktor Shabanov on 28.06.2021.
//

import UIKit

extension TextField {

    public struct Trait: Equatable {

        let isEnabled: Bool
        let isEditing: Bool
        let isEmpty: Bool

        // MARK: - Equatable

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEnabled == rhs.isEnabled
                && lhs.isEditing == rhs.isEditing
                && lhs.isEmpty == rhs.isEmpty
        }
    }
}

// MARK: - Snippets
extension TextField {

    public var trait: Trait {
        Trait(isEnabled: isEnabled,
              isEditing: isEditing,
              isEmpty: isEmpty)
    }
}