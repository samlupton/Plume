//
//  Plume.swift
//  Plume
//
//  Created by Samuel Lupton on 4/15/26.
//

/// A complete particle effect definition composed of one emitter and one or more cells.
public struct Plume {
    /// The emitter that defines how particles are spawned into the scene.
    public var emitter: Plume.Emitter

    /// The particle cells rendered by the emitter.
    public var cells: [Plume.Cell]
    
    /// Creates a plume from an emitter and an array of particle cells.
    ///
    /// - Parameters:
    ///   - emitter: The emitter preset or configuration used to spawn particles.
    ///   - cells: The cells that describe the appearance and motion of each particle.
    public init(emitter: Plume.Emitter, cells: [Plume.Cell]) {
        self.emitter = emitter
        self.cells = cells
    }
}
