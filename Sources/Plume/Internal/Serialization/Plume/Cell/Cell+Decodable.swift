//
//  Cell+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

extension Plume.Cell {
    /// A decodable representation of a particle cell.
    internal struct DataTransferObject: Decodable {
        /// The visual contents used for the particle.
        let contents: [Plume.Cell.Contents.DataTransferObject]

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
    }
}
