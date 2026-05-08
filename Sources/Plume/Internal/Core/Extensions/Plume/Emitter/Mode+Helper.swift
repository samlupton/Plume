//
//  Mode+Helper.swift
//  PlumeAnimation
//
//  Created by Samuel Lupton on 4/22/26.
//

import QuartzCore

// MARK: - Helper Methods

internal extension Plume.Emitter.Mode {
    /// Converts the internal plume emitter mode to the matching Core Animation mode.
    ///
    /// - Parameter mode: The plume emitter mode to convert.
    /// - Returns: The equivalent `CAEmitterLayerEmitterMode` value.
    static func emitterMode(from mode: Plume.Emitter.Mode) -> CAEmitterLayerEmitterMode {
        switch mode {
        case .points: return .points
        case .outline: return .outline
        case .surface: return .surface
        }
    }
}
