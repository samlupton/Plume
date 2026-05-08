//
//  Mode+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

extension Plume.Emitter.Mode: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        switch value {
        case "points": self = .points
        case "outline": self = .outline
        case "surface": self = .surface
        default:
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid emitter mode value: \(value)"
            )
        }
    }
}
