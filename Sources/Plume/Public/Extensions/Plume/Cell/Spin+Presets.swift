//
//  Spin+Presets.swift
//  Plume
//
//  Created by Samuel Lupton on 4/19/26.
//

// MARK: - Static Presets

/// Preset spin values for inactive, subtle, and high-energy rotational motion.
extension Plume.Cell.Spin {

    // MARK: - Inactive

    /// No rotational motion.
    public static let none: Self = Plume.Cell.Spin(base: 0, range: 0)

    // MARK: - Subtle Motion

    /// Barely perceptible rotation.
    public static let subtle: Self = Plume.Cell.Spin(base: 0.2, range: 0.1)

    /// Gentle, natural rotation.
    public static let gentle: Self = Plume.Cell.Spin(base: 0.8, range: 0.3)

    // MARK: - Standard Motion

    /// Balanced default rotation for most effects.
    public static let normal: Self = Plume.Cell.Spin(base: 1.5, range: 0.6)

    // MARK: - Energetic Motion

    /// Noticeable, expressive spin.
    public static let lively: Self = Plume.Cell.Spin(base: 3.0, range: 1.0)

    /// Fast, high-energy rotation.
    public static let fast: Self = Plume.Cell.Spin(base: 5.0, range: 2.0)

    // MARK: - High Variance Motion

    /// Highly energetic, unstable but intentional motion.
    public static let chaotic: Self = Plume.Cell.Spin(base: 8.0, range: 4.0)
}
