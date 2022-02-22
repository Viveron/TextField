//
//  TextField+Trait.swift
//  TextField
//
//  Created by Viktor Shabanov on 28.06.2021.
//  Copyright © 2021 Viktor Shabanov. All rights reserved.
//

import UIKit

extension TextField {

    public struct Trait: Equatable {

        public let isEnabled: Bool
        public let isEditing: Bool
        public let isEmpty: Bool

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
