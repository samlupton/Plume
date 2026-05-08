//
//  Lifetime.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

import CoreGraphics

extension Plume.Cell {
    /// Defines how long a particle remains alive, including optional variance.
    public struct Lifetime: Sendable, Decodable {
        /// The base lifetime in seconds.
        let base: CGFloat

        /// The amount of lifetime variance applied to each particle.
        let range: CGFloat
        
        /// Creates a lifetime configuration for a particle.
        ///
        /// - Parameters:
        ///   - base: Default lifespan in seconds.
        ///   - range: Variation in seconds applied per particle.
        internal init(base: CGFloat, range: CGFloat) {
            self.base = base
            self.range = range
        }
    }
}
