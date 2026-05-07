//
//  Mode.swift
//  Plume
//
//  Created by Samuel Lupton on 4/20/26.
//

internal extension Plume.Emitter {
    /// Internal emitter modes used to map public presets onto `CAEmitterLayer`.
    enum Mode: Sendable, Decodable {
        case points, outline, surface
    }
}
