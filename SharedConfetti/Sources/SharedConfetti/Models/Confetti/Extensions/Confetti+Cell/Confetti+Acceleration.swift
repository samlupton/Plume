//
//  Confetti+Acceleration.swift
//  SharedConfetti
//
//  Created by Samuel Lupton on 4/19/26.
//

import CoreGraphics

// MARK: - Acceleration

public extension Confetti.Cell {
    /// Models the acceleration of a confetti cell.
    struct Acceleration: Sendable {
        /// Acceleration in x direction.
        var x: CGFloat = .zero
        /// Acceleration in y direction.
        var y: CGFloat = .zero
        /// Acceleration in z direction.
        var z: CGFloat = .zero
    }
}
