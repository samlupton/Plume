//
//  Angle+Presets.swift
//  Plume
//
//  Created by Samuel Lupton on 4/25/26.
//

// MARK: - Static Presets

/// Preset emission angles for common directional and radial effects.
extension Plume.Cell.Angle {

    // MARK: - Cardinal Angle

    /// Rightward emission with slight angular variance for natural spread.
    public static let right: Self = Plume.Cell.Angle(base: 0, range: .pi / 8)

    /// Leftward emission with slight angular variance for natural spread.
    public static let left: Self = Plume.Cell.Angle(base: .pi, range: .pi / 8)

    /// Upward emission with slight angular variance.
    public static let up: Self = Plume.Cell.Angle(base: -(.pi / 2), range: .pi / 8)

    /// Downward emission with slight angular variance.
    public static let down: Self = Plume.Cell.Angle(base: .pi / 2, range: .pi / 8)

    // MARK: - Diagonal Angles

    /// Up-right emission with directional spread.
    public static let upRight: Self = Plume.Cell.Angle(base: -(.pi / 4), range: .pi / 8)

    /// Up-left emission with directional spread.
    public static let upLeft: Self = Plume.Cell.Angle(base: -(.pi * 3 / 4), range: .pi / 8)

    /// Down-right emission with directional spread.
    public static let downRight: Self = Plume.Cell.Angle(base: .pi / 4, range: .pi / 8)

    /// Down-left emission with directional spread.
    public static let downLeft: Self = Plume.Cell.Angle(base: .pi * 3 / 4, range: .pi / 8)

    // MARK: - Hemispheres

    /// Broad upward emission covering a wide arc (top half-space).
    public static let topHemisphere: Self = Plume.Cell.Angle(base: -(.pi / 2), range: .pi / 2)

    /// Broad downward emission covering a wide arc (bottom half-space).
    public static let bottomHemisphere: Self = Plume.Cell.Angle(base: .pi / 2, range: .pi / 2)

    /// Broad leftward emission covering a wide arc.
    public static let leftHemisphere: Self = Plume.Cell.Angle(base: .pi, range: .pi / 2)

    /// Broad rightward emission covering a wide arc.
    public static let rightHemisphere: Self = Plume.Cell.Angle(base: 0, range: .pi / 2)

    // MARK: - Full Distribution

    /// Full circular emission with no directional bias.
    public static let radial: Self = Plume.Cell.Angle(base: 0, range: .pi)
}
