//
//  Angle.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

import CoreGraphics

extension Plume.Cell {
    /// Defines the emission direction and spread for a particle.
    public struct Angle: Sendable, Decodable {
        /// The base emission angle in radians.
        let base: CGFloat

        /// The amount of angular variation around the base angle.
        let range: CGFloat
        
        /// Creates an emission angle configuration.
        ///
        /// - Parameters:
        ///   - base: Central emission angle in radians.
        ///   - range: Maximum deviation from the base angle in radians.
        internal init(base: CGFloat, range: CGFloat) {
            self.base = base
            self.range = range
        }
    }
}
