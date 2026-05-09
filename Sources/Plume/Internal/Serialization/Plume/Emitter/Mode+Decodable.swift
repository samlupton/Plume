//
//  Mode+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

extension Plume.Emitter.Mode: Decodable {
    /// Creates an emitter mode from a string representation.
    ///
    /// The decoder expects a single string value that maps to a known emitter mode:
    /// - `"points"` → emits particles from discrete points
    /// - `"outline"` → emits particles along the shape outline
    /// - `"surface"` → emits particles across the shape surface
    ///
    /// Throws a decoding error if the provided value does not match a valid mode.
    internal init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        
        switch value {
        case "points":
            self = .points
        case "outline":
            self = .outline
        case "surface":
            self = .surface
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid emitter mode value: \(value)"
            )
        }
    }
}
