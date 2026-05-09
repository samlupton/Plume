//
//  Contents+Decodable.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

import Foundation

extension Plume.Cell.Contents {
    /// A decodable representation of particle content.
    internal struct DataTransferObject: Decodable {
        /// The remote image URL used to load the particle content.
        let url: URL
        
        private enum CodingKeys: String, CodingKey {
            case url
        }

        /// Creates a particle content representation from a decoder.
        ///
        /// Decodes a remote image URL that will be used as the visual content
        /// for the particle. The URL should resolve to an image resource that can
        /// be fetched and rendered at runtime.
        internal init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.url = try container.decode(URL.self, forKey: .url)
        }
    }
}
