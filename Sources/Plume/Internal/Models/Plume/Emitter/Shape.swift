//
//  Shape.swift
//  Plume
//
//  Created by Samuel Lupton on 4/20/26.
//

internal extension Plume.Emitter {
    /// Internal emitter shapes used to map public presets onto `CAEmitterLayer`.
    enum Shape: Sendable {
        case point, line, rectangle, circle
    }
}
