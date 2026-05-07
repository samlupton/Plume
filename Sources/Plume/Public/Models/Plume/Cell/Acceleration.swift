//
//  Acceleration.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

import CoreGraphics

extension Plume.Cell {
    /// Defines the horizontal and vertical acceleration applied to a particle over time.
    public struct Acceleration: Sendable, Decodable {
        /// Horizontal acceleration.
        let x: CGFloat

        /// Vertical acceleration.
        let y: CGFloat
        
        /// Creates a custom acceleration vector.
        ///
        /// - Parameters:
        ///   - x: Horizontal acceleration in points per second squared.
        ///   - y: Vertical acceleration in points per second squared.
        internal init(x: CGFloat, y: CGFloat) {
            self.x = x
            self.y = y
        }
    }
}
