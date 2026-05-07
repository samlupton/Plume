//
//  Emitter.swift
//  Plume
//
//  Created by Samuel Lupton on 4/20/26.
//

import CoreGraphics

extension Plume {
    /// Describes how a plume emits its particles.
    ///
    /// Instances are typically created through the public emitter preset helpers
    /// rather than direct initialization.
    public struct Emitter: Sendable, Decodable {
        /// The underlying emitter shape used by Core Animation.
        let shape: Plume.Emitter.Shape

        /// The underlying emitter mode used by Core Animation.
        let mode: Plume.Emitter.Mode

        /// The number of particles emitted over time.
        let birthRate: CGFloat
        
        /// Creates a custom emitter configuration.
        ///
        /// - Parameters:
        ///   - shape: Geometric emission shape.
        ///   - mode: Emission distribution mode.
        ///   - birthRate: Number of particles emitted per second.
        internal init(shape: Plume.Emitter.Shape, mode: Plume.Emitter.Mode, birthRate: CGFloat) {
            self.shape = shape
            self.mode = mode
            self.birthRate = birthRate
        }
    }
}
