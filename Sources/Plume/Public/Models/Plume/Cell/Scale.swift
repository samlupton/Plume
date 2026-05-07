//
//  Scale.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

import CoreGraphics

extension Plume.Cell {
    /// Defines the particle size and size variance.
    public struct Scale: Sendable, Decodable {
        /// The base rendered scale of the particle.
        let base: CGFloat

        /// The amount of scale variance applied to each particle.
        let range: CGFloat
        
        /// Creates a scale configuration for particle rendering.
        ///
        /// - Parameters:
        ///   - base: Default size multiplier.
        ///   - range: Variation applied per particle.
        internal init(base: CGFloat, range: CGFloat) {
            self.base = base
            self.range = range
        }
    }
}
