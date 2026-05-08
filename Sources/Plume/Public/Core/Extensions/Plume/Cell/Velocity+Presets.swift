//
//  Velocity+Presets.swift
//  Plume
//
//  Created by Samuel Lupton on 4/25/26.
//

// MARK: - Static Presets

/// Preset velocity values for ambient, standard, and explosive movement.
extension Plume.Cell.Velocity {

    // MARK: - Inactive

    /// No movement. Particles remain stationary aside from other forces.
    public static let zero: Self = Plume.Cell.Velocity(base: .zero, range: .zero)

    // MARK: - Subtle Motion

    /// Barely perceptible movement, suitable for ambient effects.
    public static let gentle: Self = Plume.Cell.Velocity(base: 30, range: 8)

    // MARK: - Standard Motion

    /// Balanced default motion for most effects.
    public static let standard: Self = Plume.Cell.Velocity(base: 100, range: 25)

    // MARK: - Energetic Motion

    /// Clearly visible motion with strong presence.
    public static let lively: Self = Plume.Cell.Velocity(base: 200, range: 60)

    // MARK: - High-Intensity Motion

    /// Fast, forceful movement for dramatic or high-impact effects.
    public static let explosive: Self = Plume.Cell.Velocity(base: 400, range: 150)
}
