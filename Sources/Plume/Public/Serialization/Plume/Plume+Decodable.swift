//
//  Plume+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

import Foundation

// MARK: - Data Transfer Object

extension Plume {
    /// A decodable representation of a plume.
    public struct DataTransferObject: Decodable {
        /// The emitter that defines how particles are spawned into the scene.
        public var emitter: Plume.Emitter

        /// The particle cells rendered by the emitter.
        public var templateCell: Plume.Cell.DataTransferObject
    }
}
