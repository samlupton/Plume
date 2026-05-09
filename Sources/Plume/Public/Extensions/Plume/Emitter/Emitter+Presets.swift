//
//  Emitter+Presets.swift
//  PlumeAnimation
//
//  Created by Samuel Lupton on 4/22/26.
//

import CoreFoundation

// MARK: - Static Presets

/// Preset emitter constructors that expose the supported public plume emission styles.
extension Plume.Emitter {

    /// Creates a point-based emitter.
    ///
    /// Particles are emitted from a single origin point,
    /// making this suitable for bursts, explosions, or
    /// tightly focused effects.
    ///
    /// - Parameter birthRate: The number of particles emitted per second.
    /// - Returns: A point-based emitter configuration.
    public static func point(birthRate: CGFloat) -> Plume.Emitter {
        return Plume.Emitter(shape: .point, mode: .points, birthRate: birthRate)
    }

    /// Creates a line-based emitter.
    ///
    /// Particles are emitted along a linear path,
    /// producing effects such as rain, streams, or
    /// directional flows.
    ///
    /// - Parameter birthRate: The number of particles emitted per second.
    /// - Returns: A line-based emitter configuration.
    public static func line(birthRate: CGFloat) -> Plume.Emitter {
        return Plume.Emitter(shape: .line, mode: .outline, birthRate: birthRate)
    }

    /// Creates a circular emitter.
    ///
    /// Particles are emitted across the surface of a circle,
    /// ideal for radial or outward-expanding effects.
    ///
    /// - Parameter birthRate: The number of particles emitted per second.
    /// - Returns: A circular emitter configuration.
    public static func circle(birthRate: CGFloat) -> Plume.Emitter {
        return Plume.Emitter(shape: .circle, mode: .surface, birthRate: birthRate)
    }

    /// Creates a rectangular emitter.
    ///
    /// Particles are emitted across a rectangular area,
    /// useful for full-area coverage such as snowfall or
    /// ambient background effects.
    ///
    /// - Parameter birthRate: The number of particles emitted per second.
    /// - Returns: A rectangular emitter configuration.
    public static func rectangle(birthRate: CGFloat) -> Plume.Emitter {
        return Plume.Emitter(shape: .rectangle, mode: .surface, birthRate: birthRate)
    }
}
