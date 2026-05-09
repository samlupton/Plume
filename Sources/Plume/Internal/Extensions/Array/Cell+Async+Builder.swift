//
//  Cell+Async+Builder.swift
//  Plume
//
//  Created by Samuel Lupton on 5/8/26.
//

import UIKit

// MARK: - Plume Cell Array Factories

extension Array where Element == Plume.Cell {
    /// Creates an array of `Plume.Cell` from a `Plume.DataTransferObject`.
    ///
    /// Each remote image referenced by the data transfer object is loaded and
    /// converted into a particle cell using the shared configuration stored in
    /// the template cell.
    ///
    /// - Parameter dataTransferObject: The plume data transfer object used to build the cells.
    /// - Returns: An array of configured `Plume.Cell` instances.
    /// - Throws: An error if any image download fails.
    @available(iOS 17.0, *)
    internal static func make(with dataTransferObject: Plume.Cell.DataTransferObject) async throws -> [Plume.Cell] {
        try await withThrowingTaskGroup { group in
            let urls = dataTransferObject.contents.map { $0.url }
            
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
                    lifetime: dataTransferObject.lifetime,
                    spin: dataTransferObject.spin,
                    scale: dataTransferObject.scale,
                    acceleration: dataTransferObject.acceleration,
                    velocity: dataTransferObject.velocity,
                    angle: dataTransferObject.angle
                )
            }
        }
    }
}
