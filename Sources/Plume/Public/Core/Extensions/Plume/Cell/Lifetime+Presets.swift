//
//  Lifetime+Presets.swift
//  Plume
//
//  Created by Samuel Lupton on 4/25/26.
//

// MARK: - Static Presets

/// Preset lifetime values for short, extended, and ambient plume behaviors.
extension Plume.Cell.Lifetime {

    // MARK: - Immediate / Feedback

    /// Near-instant feedback (tap, impact, micro-response).
    public static let instant: Self = .init(base: 0.25, range: 0.10)

    /// Extremely short-lived motion, almost like a blink.
    public static let flash: Self = .init(base: 0.5, range: 0.15)

    // MARK: - Short-lived Motion

    /// Very quick motion with minimal persistence.
    public static let short: Self = .init(base: 0.9, range: 0.25)

    /// Default balanced behavior for most UI effects.
    public static let normal: Self = .init(base: 2.5, range: 0.8)

    // MARK: - Extended Presence

    /// Noticeable presence without becoming ambient.
    public static let long: Self = .init(base: 6.0, range: 2.0)

    /// Extended visible lifecycle for expressive or celebratory effects.
    public static let extended: Self = .init(base: 10.0, range: 3.0)

    // MARK: - Ambient / Background Behavior

    /// Background-level motion that still reads as intentional UI.
    public static let persistent: Self = .init(base: 15.0, range: 5.0)

    /// Slow atmospheric behavior for ambient layers.
    public static let ambient: Self = .init(base: 25.0, range: 8.0)

    /// Very long-lived behavior for continuous or system-like motion.
    public static let continuous: Self = .init(base: 45.0, range: 15.0)
}
