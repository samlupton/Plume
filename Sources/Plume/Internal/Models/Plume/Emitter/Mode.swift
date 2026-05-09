//
//  Mode.swift
//  Plume
//
//  Created by Samuel Lupton on 4/20/26.
//

extension Plume.Emitter {
    /// Internal emitter modes used to map public presets onto `CAEmitterLayer`.
    internal enum Mode: Sendable {
        case points, outline, surface
    }
}
