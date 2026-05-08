//
//  Cell.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

extension Plume {
    /// Describes a single particle style within a plume.
    public struct Cell: Sendable {
        /// The visual contents used for the particle.
        let contents: Plume.Cell.Contents

        /// The time span for which the particle remains visible.
        let lifetime: Plume.Cell.Lifetime

        /// The rotational behavior applied to the particle.
        let spin: Plume.Cell.Spin

        /// The base scale and scale variance for the particle.
        let scale: Plume.Cell.Scale

        /// The acceleration applied to the particle after emission.
        let acceleration: Plume.Cell.Acceleration

        /// The initial speed and speed variance for the particle.
        let velocity: Plume.Cell.Velocity

        /// The emission direction and spread for the particle.
        let angle: Plume.Cell.Angle
        
        /// Creates a particle cell from its visual and motion components.
        ///
        /// - Parameters:
        ///   - contents: The particle's image content.
        ///   - lifetime: The amount of time the particle should remain alive.
        ///   - spin: The rotational behavior of the particle.
        ///   - scale: The particle's size and size variance.
        ///   - acceleration: The acceleration applied over time.
        ///   - velocity: The particle's initial speed characteristics.
        ///   - angle: The particle's emission direction and spread.
        internal init(
            contents: Plume.Cell.Contents,
            lifetime: Plume.Cell.Lifetime,
            spin: Plume.Cell.Spin,
            scale: Plume.Cell.Scale,
            acceleration: Plume.Cell.Acceleration,
            velocity: Plume.Cell.Velocity,
            angle: Plume.Cell.Angle
        ) {
            self.contents = contents
            self.lifetime = lifetime
            self.spin = spin
            self.scale = scale
            self.acceleration = acceleration
            self.velocity = velocity
            self.angle = angle
        }
    }
}
