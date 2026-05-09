//
//  Shape+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

extension Plume.Emitter.Shape: Decodable {
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
