//
//  Contents.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

import UIKit

extension Plume.Cell {
    /// Encapsulates the image used to render a particle.
    internal struct Contents: Sendable {
        /// The backing Core Graphics image used by the emitter cell.
        let image: CGImage?
        
        /// Creates particle contents from a Core Graphics image.
        ///
        /// - Parameter cgimage: The image used to render the particle.
        internal init(cgimage: CGImage) {
            self.image = cgimage
        }
        
        /// Creates particle contents from a UIKit image.
        ///
        /// - Parameter uiimage: The image used to render the particle.
        internal init(uiimage: UIImage) {
            self.image = uiimage.cgImage
        }

        /// Creates particle contents from an asset catalog image resource.
        ///
        /// - Parameter resource: The image resource used to render the particle.
        @available(iOS 17.0, *)
        internal init(resource: ImageResource) {
            self.image = UIImage(resource: resource).cgImage
        }

        /// Creates particle contents by downloading an image from a remote URL.
        ///
        /// - Parameter url: The remote image location.
        /// - Throws: An error if the image data cannot be fetched.
        @available(iOS 15.0, *)
        internal init(url: URL) async throws {
            let (data, _) = try await URLSession.shared.data(from: url)
            let uiimage = UIImage(data: data)
            self.image = uiimage?.cgImage
        }
    }
}
