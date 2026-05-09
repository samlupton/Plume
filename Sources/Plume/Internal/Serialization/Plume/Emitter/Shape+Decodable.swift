//
//  Shape+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

extension Plume.Emitter.Shape: Decodable {
    /// Creates an emitter shape from its string representation.
    ///
    /// The decoder expects a single string value that defines the geometric
    /// shape used for particle emission:
    /// - `"point"` → emits from a single point
    /// - `"line"` → emits along a line
    /// - `"rectangle"` → emits across a rectangular area
    /// - `"circle"` → emits within a circular region
    ///
    /// Throws a decoding error if the provided value does not match a supported shape.
    internal init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        switch value {
        case "point":
            self = .point
        case "line":
            self = .line
        case "rectangle":
            self = .rectangle
        case "circle":
            self = .circle
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid emitter shape value: \(value)"
            )
        }
    }
}
