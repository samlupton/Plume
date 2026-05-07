//
//  Velocity.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

import CoreGraphics

extension Plume.Cell {
    /// Defines the initial speed of a particle and its speed variance.
    public struct Velocity: Sendable, Decodable {
        /// The base velocity applied at emission time.
        let base: CGFloat

        /// The amount of velocity variance applied to each particle.
        let range: CGFloat
        
        /// Creates a velocity configuration for particle emission.
        ///
        /// - Parameters:
        ///   - base: Default emission speed.
        ///   - range: Variation applied per particle.
        internal init(base: CGFloat, range: CGFloat) {
            self.base = base
            self.range = range
        }
    }
}
