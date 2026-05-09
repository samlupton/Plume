//
//  Shape.swift
//  Plume
//
//  Created by Samuel Lupton on 4/20/26.
//

extension Plume.Emitter {
    /// Internal emitter shapes used to map public presets onto `CAEmitterLayer`.
    internal enum Shape: Sendable {
        case point, line, rectangle, circle
    }
}
