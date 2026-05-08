//
//  Scale+Presets.swift
//  Plume
//
//  Created by Samuel Lupton on 4/25/26.
//

// MARK: - Static Presets

/// Preset scale values for small, standard, and oversized particle appearances.
extension Plume.Cell.Scale {

    // MARK: - Subtle

    /// Very small, minimal visual presence.
    public static let tiny: Self = Plume.Cell.Scale(base: 0.3, range: 0.1)

    /// Small and delicate particles.
    public static let small: Self = Plume.Cell.Scale(base: 0.6, range: 0.15)

    // MARK: - Standard

    /// Neutral default size.
    public static let normal: Self = Plume.Cell.Scale(base: 1.0, range: 0.2)

    // MARK: - Emphasis

    /// Slightly larger, more visible particles.
    public static let large: Self = Plume.Cell.Scale(base: 1.4, range: 0.3)

    /// Strong visual presence.
    public static let huge: Self = Plume.Cell.Scale(base: 2.0, range: 0.5)

    // MARK: - Extreme

    /// Dramatic, oversized particles for impact moments.
    public static let massive: Self = Plume.Cell.Scale(base: 3.0, range: 0.8)
}
