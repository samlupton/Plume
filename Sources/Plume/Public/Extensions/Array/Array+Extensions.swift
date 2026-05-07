//
//  Array+Extensions.swift
//  Plume
//
//  Created by Samuel Lupton on 4/26/26.
//

import UIKit

// MARK: - Plume Cell Array Factories

/// Convenience factories for building arrays of `Plume.Cell` from image collections.
extension Array where Element == Plume.Cell {
    /// Creates an array of `Plume.Cell` from a collection of `UIImage` values.
    ///
    /// Each image is converted into a particle cell using the provided
    /// lifetime, spin, scale, acceleration, velocity, and angle values.
    ///
    /// - Parameters:
    ///   - uiimages: The images used as the visual contents of each cell.
    ///   - lifetime: The lifetime configuration applied to all cells.
    ///   - spin: The rotational behavior applied to all cells.
    ///   - scale: The size configuration applied to all cells.
    ///   - acceleration: The acceleration applied to all cells.
    ///   - velocity: The velocity applied to all cells.
    ///   - angle: The emission angle applied to all cells.
    /// - Returns: An array of configured `Plume.Cell` instances.
    public static func make(
        from uiimages: [UIImage],
        lifetime: Plume.Cell.Lifetime,
        spin: Plume.Cell.Spin,
        scale: Plume.Cell.Scale,
        acceleration: Plume.Cell.Acceleration,
        velocity: Plume.Cell.Velocity,
        angle: Plume.Cell.Angle
    ) -> [Plume.Cell] {
        uiimages.map { uiimage in
            Plume.Cell(
                contents: Plume.Cell.Contents(uiimage: uiimage),
                lifetime: lifetime,
                spin: spin,
                scale: scale,
                acceleration: acceleration,
                velocity: velocity,
                angle: angle
            )
        }
    }

    /// Creates an array of `Plume.Cell` from a collection of `CGImage` values.
    ///
    /// Each image is converted into a particle cell using the provided
    /// lifetime, spin, scale, acceleration, velocity, and angle values.
    ///
    /// - Parameters:
    ///   - cgimages: The images used as the visual contents of each cell.
    ///   - lifetime: The lifetime configuration applied to all cells.
    ///   - spin: The rotational behavior applied to all cells.
    ///   - scale: The size configuration applied to all cells.
    ///   - acceleration: The acceleration applied to all cells.
    ///   - velocity: The velocity applied to all cells.
    ///   - angle: The emission angle applied to all cells.
    /// - Returns: An array of configured `Plume.Cell` instances.
    public static func make(
        from cgimages: [CGImage],
        lifetime: Plume.Cell.Lifetime,
        spin: Plume.Cell.Spin,
        scale: Plume.Cell.Scale,
        acceleration: Plume.Cell.Acceleration,
        velocity: Plume.Cell.Velocity,
        angle: Plume.Cell.Angle
    ) -> [Plume.Cell] {
        cgimages.map { cgimage in
            Plume.Cell(
                contents: Plume.Cell.Contents(cgimage: cgimage),
                lifetime: lifetime,
                spin: spin,
                scale: scale,
                acceleration: acceleration,
                velocity: velocity,
                angle: angle
            )
        }
    }

    /// Creates an array of `Plume.Cell` from a collection of `ImageResource` values.
    ///
    /// Each image resource is converted into a particle cell using the provided
    /// lifetime, spin, scale, acceleration, velocity, and angle values.
    ///
    /// - Parameters:
    ///   - resources: The image resources used as the visual contents of each cell.
    ///   - lifetime: The lifetime configuration applied to all cells.
    ///   - spin: The rotational behavior applied to all cells.
    ///   - scale: The size configuration applied to all cells.
    ///   - acceleration: The acceleration applied to all cells.
    ///   - velocity: The velocity applied to all cells.
    ///   - angle: The emission angle applied to all cells.
    /// - Returns: An array of configured `Plume.Cell` instances.
    @available(iOS 17.0, *)
    public static func make(
        from resources: [ImageResource],
        lifetime: Plume.Cell.Lifetime,
        spin: Plume.Cell.Spin,
        scale: Plume.Cell.Scale,
        acceleration: Plume.Cell.Acceleration,
        velocity: Plume.Cell.Velocity,
        angle: Plume.Cell.Angle
    ) -> [Plume.Cell] {
        resources.map { resource in
            Plume.Cell(
                contents: Plume.Cell.Contents(resource: resource),
                lifetime: lifetime,
                spin: spin,
                scale: scale,
                acceleration: acceleration,
                velocity: velocity,
                angle: angle
            )
        }
    }
    
    /// Creates an array of `Plume.Cell` from a collection of remote image URLs.
    ///
    /// Each image is loaded from its URL and converted into a particle cell
    /// using the provided lifetime, spin, scale, acceleration, velocity,
    /// and angle values.
    ///
    /// - Parameters:
    ///   - urls: The remote image URLs used as the visual contents of each cell.
    ///   - lifetime: The lifetime configuration applied to all cells.
    ///   - spin: The rotational behavior applied to all cells.
    ///   - scale: The size configuration applied to all cells.
    ///   - acceleration: The acceleration applied to all cells.
    ///   - velocity: The velocity applied to all cells.
    ///   - angle: The emission angle applied to all cells.
    /// - Returns: An array of configured `Plume.Cell` instances.
    /// - Throws: An error if any image download fails.
    @available(iOS 17.0, *)
    public static func make(
        from urls: [URL],
        lifetime: Plume.Cell.Lifetime,
        spin: Plume.Cell.Spin,
        scale: Plume.Cell.Scale,
        acceleration: Plume.Cell.Acceleration,
        velocity: Plume.Cell.Velocity,
        angle: Plume.Cell.Angle
    ) async throws -> [Plume.Cell] {
        try await withThrowingTaskGroup { group in
            for url in urls {
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    return UIImage(data: data)?.cgImage
                }
            }
            
            var cgimages: [CGImage] = []
            
            for try await cgimage in group {
                if let cgimage {
                    cgimages.append(cgimage)
                }
            }
            
            return cgimages.map { cgimage in
                Plume.Cell(
                    contents: Plume.Cell.Contents(cgimage: cgimage),
                    lifetime: lifetime,
                    spin: spin,
                    scale: scale,
                    acceleration: acceleration,
                    velocity: velocity,
                    angle: angle
                )
            }
        }
    }
}
