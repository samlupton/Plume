//
//  Plume+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

// MARK: - Data Transfer Object

extension Plume {
    /// A decodable representation of a plume.
    ///
    /// The `cell` acts as a template for all particles emitted by the emitter.
    /// Each emitted particle is based on this configuration, meaning changes here
    /// define the visual and behavioral baseline for all spawned cells.
    ///
    /// The cell also supports multiple image URLs, allowing variation in particle
    /// appearance. This enables more visually diverse effects by randomly or
    /// sequentially selecting from the provided image sources.
    public struct DataTransferObject: Decodable {
        /// The emitter that defines how particles are spawned into the scene.
        public var emitter: Plume.Emitter

        /// The cell acts as a template for all particles emitted by the emitter.
        public var cell: Plume.Cell.DataTransferObject
    }
}
