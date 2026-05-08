//
//  PlumeUIView.swift
//  Plume
//
//  Created by Samuel Lupton on 10/7/25.
//

import UIKit

// TODO: Consider if this should be a public facing component.
// TODO: Add support for haptics.
// TODO: Add support for audio.

/// A `UIView` responsible for rendering and emitting plume particles.
///
/// `PlumeView` acts as a thin wrapper around `PlumeLayer`, handling
/// its lifecycle and attaching it to the view’s backing layer. Upon
/// initialization, it immediately begins emitting particles using the
/// provided plume.
public final class PlumeUIView: UIView {
    
    /// The plume definition rendered by this view.
    private let plume: Plume
    
    /// Creates a UIKit plume view from a plume definition.
    ///
    /// - Parameter plume: The plume rendered and emitted by the view.
    public init(plume: Plume) {
        self.plume = plume
        super.init(frame: .zero)
        
        // By default, this view will not steal taps.
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Actions

    /// Emits the plume using the current view bounds as the emitter container.
    public func emit() {
        let emitter = makeCAEmitter(with: plume)
        
        layer.addSublayer(emitter)
        guard let animation = makeBirthRateAnimation() else { return }
        
        let id = UUID().uuidString
        emitter.add(animation, forKey: id)
    }

    // MARK: - Internal Builders

    private func makeCACell(cell: Plume.Cell) -> CAEmitterCell {
        let cacell = CAEmitterCell()
        cacell.beginTime = CACurrentMediaTime()
        cacell.xAcceleration = cell.acceleration.x
        cacell.yAcceleration = cell.acceleration.y
        cacell.contents = cell.contents.image
        cacell.emissionLongitude = cell.angle.base
        cacell.emissionRange = cell.angle.range
        cacell.scale = cell.scale.base
        cacell.scaleRange = cell.scale.range
        cacell.velocity = cell.velocity.base
        cacell.velocityRange = cell.velocity.range
        cacell.lifetime = Float(cell.lifetime.base)
        cacell.lifetimeRange = Float(cell.lifetime.range)
        cacell.spin = cell.spin.base
        cacell.spinRange = cell.spin.range

        // TODO: Add support for birthRate (of CAEmitterCell) property.
        cacell.birthRate = 1

        // TODO: Add support for scaleSpeed property.
        cacell.scaleSpeed = .zero

        // TODO: Add support for contentsScale property.
        cacell.contentsScale = 1
        
        return cacell
    }
    
    // TODO: Improve support for animations.
    private func makeCAEmitter(with plume: Plume) -> CAEmitterLayer {
        let caemitter = CAEmitterLayer()
        caemitter.birthRate = Float(plume.emitter.birthRate)
        caemitter.emitterSize = resolveSize(for: plume.emitter.shape, in: bounds)
        caemitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        caemitter.emitterMode = Plume.Emitter.Mode.emitterMode(from: plume.emitter.mode)
        caemitter.emitterShape = Plume.Emitter.Shape.emitterShape(from: plume.emitter.shape)
        caemitter.emitterCells = plume.cells.map { cell in
            return makeCACell(cell: cell)
        }
        
        return caemitter
    }
    
    // TODO: Add support for animations.
    /// Builds the birth-rate animation used to ramp the emitter down after firing.
    private func makeBirthRateAnimation() -> CABasicAnimation? {
        let animation = CABasicAnimation(keyPath: "birthRate")
        animation.fromValue = plume.emitter.birthRate
        animation.toValue = 0
        animation.duration = 0.5
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
}

// MARK: - Layout Helpers

extension PlumeUIView {
    /// Resolves the Core Animation emitter size for a plume shape within a given rectangle.
    ///
    /// - Parameters:
    ///   - shape: The plume emitter shape.
    ///   - rect: The bounds used to size the emitter.
    /// - Returns: The emitter size appropriate for the provided shape.
    private func resolveSize(for shape: Plume.Emitter.Shape, in rect: CGRect) -> CGSize {
        switch shape {
        case .point:
            return .zero
        case .line:
            return CGSize(width: rect.width, height: .zero)
        case .circle:
            let length = min(rect.width, rect.height)
            return CGSize(width: length, height: length)
        case .rectangle:
            return rect.size
        }
    }
}
