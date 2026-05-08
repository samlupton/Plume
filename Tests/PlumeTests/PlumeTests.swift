//
//  PlumeTests.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

import SwiftUI
import UIKit
import XCTest
@testable import Plume

@MainActor
final class PlumeTests: XCTestCase {
    func testPlumeInitializerStoresEmitterAndCells() {
        let emitter = Plume.Emitter.circle(birthRate: 10)
        let cells = makeCells(from: [makeUIImage()])

        let plume = Plume(emitter: emitter, cells: cells)

        XCTAssertEqual(plume.emitter.shape, .circle)
        XCTAssertEqual(plume.emitter.mode, .surface)
        XCTAssertEqual(plume.emitter.birthRate, 10)
        XCTAssertEqual(plume.cells.count, 1)
        XCTAssertEqual(plume.cells[0].lifetime.base, CellLifetime.ambient.base)
        XCTAssertEqual(plume.cells[0].spin.base, CellSpin.chaotic.base)
    }

    func testEmitterPresetsUseExpectedShapeModeAndBirthRate() {
        let point = Plume.Emitter.point(birthRate: 12)
        XCTAssertEqual(point.shape, .point)
        XCTAssertEqual(point.mode, .points)
        XCTAssertEqual(point.birthRate, 12)

        let line = Plume.Emitter.line(birthRate: 13)
        XCTAssertEqual(line.shape, .line)
        XCTAssertEqual(line.mode, .outline)
        XCTAssertEqual(line.birthRate, 13)

        let circle = Plume.Emitter.circle(birthRate: 14)
        XCTAssertEqual(circle.shape, .circle)
        XCTAssertEqual(circle.mode, .surface)
        XCTAssertEqual(circle.birthRate, 14)

        let rectangle = Plume.Emitter.rectangle(birthRate: 15)
        XCTAssertEqual(rectangle.shape, .rectangle)
        XCTAssertEqual(rectangle.mode, .surface)
        XCTAssertEqual(rectangle.birthRate, 15)
    }

    func testAccelerationPresets() {
        assertAcceleration(.zero, x: 0, y: 0)
        assertAcceleration(.gravityLight, x: 0, y: 100)
        assertAcceleration(.gravity, x: 0, y: 300)
        assertAcceleration(.gravityHeavy, x: 0, y: 800)
        assertAcceleration(.liftLight, x: 0, y: -80)
        assertAcceleration(.lift, x: 0, y: -200)
        assertAcceleration(.liftStrong, x: 0, y: -500)
        assertAcceleration(.driftLeft, x: -50, y: 0)
        assertAcceleration(.driftRight, x: 50, y: 0)
        assertAcceleration(.downLeft, x: -120, y: 300)
        assertAcceleration(.downRight, x: 120, y: 300)
        assertAcceleration(.upLeft, x: -100, y: -200)
        assertAcceleration(.upRight, x: 100, y: -200)
    }

    func testAnglePresets() {
        assertAngle(.right, base: 0, range: .pi / 8)
        assertAngle(.left, base: .pi, range: .pi / 8)
        assertAngle(.up, base: -(.pi / 2), range: .pi / 8)
        assertAngle(.down, base: .pi / 2, range: .pi / 8)
        assertAngle(.upRight, base: -(.pi / 4), range: .pi / 8)
        assertAngle(.upLeft, base: -(.pi * 3 / 4), range: .pi / 8)
        assertAngle(.downRight, base: .pi / 4, range: .pi / 8)
        assertAngle(.downLeft, base: .pi * 3 / 4, range: .pi / 8)
        assertAngle(.topHemisphere, base: -(.pi / 2), range: .pi / 2)
        assertAngle(.bottomHemisphere, base: .pi / 2, range: .pi / 2)
        assertAngle(.leftHemisphere, base: .pi, range: .pi / 2)
        assertAngle(.rightHemisphere, base: 0, range: .pi / 2)
        assertAngle(.radial, base: 0, range: .pi)
    }

    func testLifetimePresets() {
        assertLifetime(.instant, base: 0.25, range: 0.10)
        assertLifetime(.flash, base: 0.5, range: 0.15)
        assertLifetime(.short, base: 0.9, range: 0.25)
        assertLifetime(.normal, base: 2.5, range: 0.8)
        assertLifetime(.long, base: 6.0, range: 2.0)
        assertLifetime(.extended, base: 10.0, range: 3.0)
        assertLifetime(.persistent, base: 15.0, range: 5.0)
        assertLifetime(.ambient, base: 25.0, range: 8.0)
        assertLifetime(.continuous, base: 45.0, range: 15.0)
    }

    func testScalePresets() {
        assertScale(.tiny, base: 0.3, range: 0.1)
        assertScale(.small, base: 0.6, range: 0.15)
        assertScale(.normal, base: 1.0, range: 0.2)
        assertScale(.large, base: 1.4, range: 0.3)
        assertScale(.huge, base: 2.0, range: 0.5)
        assertScale(.massive, base: 3.0, range: 0.8)
    }

    func testSpinPresets() {
        assertSpin(.none, base: 0, range: 0)
        assertSpin(.subtle, base: 0.2, range: 0.1)
        assertSpin(.gentle, base: 0.8, range: 0.3)
        assertSpin(.normal, base: 1.5, range: 0.6)
        assertSpin(.lively, base: 3.0, range: 1.0)
        assertSpin(.fast, base: 5.0, range: 2.0)
        assertSpin(.chaotic, base: 8.0, range: 4.0)
    }

    func testVelocityPresets() {
        assertVelocity(.zero, base: 0, range: 0)
        assertVelocity(.gentle, base: 30, range: 8)
        assertVelocity(.standard, base: 100, range: 25)
        assertVelocity(.lively, base: 200, range: 60)
        assertVelocity(.explosive, base: 400, range: 150)
    }

    func testArrayFactoryFromUIImageBuildsCellsWithSharedConfiguration() {
        let imageA = makeUIImage(color: .red)
        let imageB = makeUIImage(color: .blue)

        let cells = [Plume.Cell].make(
            from: [imageA, imageB],
            lifetime: .ambient,
            spin: .chaotic,
            scale: .huge,
            acceleration: .downLeft,
            velocity: .explosive,
            angle: .bottomHemisphere
        )

        XCTAssertEqual(cells.count, 2)
        assertCell(cells[0], expectedPixelWidth: imageA.cgImage?.width, expectedPixelHeight: imageA.cgImage?.height)
        assertCell(cells[1], expectedPixelWidth: imageB.cgImage?.width, expectedPixelHeight: imageB.cgImage?.height)
    }

    func testArrayFactoryFromCGImageBuildsCellsWithSharedConfiguration() throws {
        let imageA = try XCTUnwrap(makeUIImage(color: .green).cgImage)
        let imageB = try XCTUnwrap(makeUIImage(color: .yellow).cgImage)

        let cells = [Plume.Cell].make(
            from: [imageA, imageB],
            lifetime: .ambient,
            spin: .chaotic,
            scale: .huge,
            acceleration: .downLeft,
            velocity: .explosive,
            angle: .bottomHemisphere
        )

        XCTAssertEqual(cells.count, 2)
        assertCell(cells[0], expectedPixelWidth: imageA.width, expectedPixelHeight: imageA.height)
        assertCell(cells[1], expectedPixelWidth: imageB.width, expectedPixelHeight: imageB.height)
    }

    func testEmitterModeHelperMapsEveryInternalCaseToCoreAnimation() {
        XCTAssertEqual(Plume.Emitter.Mode.emitterMode(from: .points), .points)
        XCTAssertEqual(Plume.Emitter.Mode.emitterMode(from: .outline), .outline)
        XCTAssertEqual(Plume.Emitter.Mode.emitterMode(from: .surface), .surface)
    }

    func testEmitterShapeHelperMapsEveryInternalCaseToCoreAnimation() {
        XCTAssertEqual(Plume.Emitter.Shape.emitterShape(from: .point), .point)
        XCTAssertEqual(Plume.Emitter.Shape.emitterShape(from: .line), .line)
        XCTAssertEqual(Plume.Emitter.Shape.emitterShape(from: .rectangle), .rectangle)
        XCTAssertEqual(Plume.Emitter.Shape.emitterShape(from: .circle), .circle)
    }

    func testTypealiasesReferToPlumeTypes() {
        let acceleration: CellAcceleration = .gravity
        let angle: CellAngle = .radial
        let lifetime: CellLifetime = .normal
        let scale: CellScale = .large
        let spin: CellSpin = .fast
        let velocity: CellVelocity = .lively
        let emitter: PlumeEmitter = .circle(birthRate: 20)
        let cell: PlumeCell = makeCells(from: [makeUIImage()])[0]

        XCTAssertEqual(acceleration.y, Plume.Cell.Acceleration.gravity.y)
        XCTAssertEqual(angle.range, Plume.Cell.Angle.radial.range)
        XCTAssertEqual(lifetime.base, Plume.Cell.Lifetime.normal.base)
        XCTAssertEqual(scale.base, Plume.Cell.Scale.large.base)
        XCTAssertEqual(spin.base, Plume.Cell.Spin.fast.base)
        XCTAssertEqual(velocity.base, Plume.Cell.Velocity.lively.base)
        XCTAssertEqual(emitter.shape, .circle)
        XCTAssertEqual(cell.scale.base, Plume.Cell.Scale.huge.base)
    }

    func testPlumeUIViewStartsNonInteractive() {
        let view = PlumeUIView(plume: makePlume(shape: .point))

        XCTAssertFalse(view.isUserInteractionEnabled)
    }

    func testPlumeUIViewEmitAddsConfiguredEmitterLayerForEachShape() {
        assertEmitterLayer(for: .point, expectedSize: .zero, expectedMode: .points, expectedLayerMode: .points, expectedLayerShape: .point)
        assertEmitterLayer(for: .line, expectedSize: CGSize(width: 120, height: 0), expectedMode: .outline, expectedLayerMode: .outline, expectedLayerShape: .line)
        assertEmitterLayer(for: .circle, expectedSize: CGSize(width: 80, height: 80), expectedMode: .surface, expectedLayerMode: .surface, expectedLayerShape: .circle)
        assertEmitterLayer(for: .rectangle, expectedSize: CGSize(width: 120, height: 80), expectedMode: .surface, expectedLayerMode: .surface, expectedLayerShape: .rectangle)
    }

    func testPlumeViewCoordinatorStartsAtZero() {
        let coordinator = PlumeView(plume: makePlume(shape: .line), trigger: 5).makeCoordinator()

        XCTAssertEqual(coordinator.lastTrigger, 0)
    }
}

private extension PlumeTests {
    enum EmitterPreset {
        case point
        case line
        case circle
        case rectangle
    }

    func assertAcceleration(_ acceleration: Plume.Cell.Acceleration, x: CGFloat, y: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(acceleration.x, x, file: file, line: line)
        XCTAssertEqual(acceleration.y, y, file: file, line: line)
    }

    func assertAngle(_ angle: Plume.Cell.Angle, base: CGFloat, range: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(angle.base, base, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(angle.range, range, accuracy: 0.0001, file: file, line: line)
    }

    func assertLifetime(_ lifetime: Plume.Cell.Lifetime, base: CGFloat, range: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(lifetime.base, base, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(lifetime.range, range, accuracy: 0.0001, file: file, line: line)
    }

    func assertScale(_ scale: Plume.Cell.Scale, base: CGFloat, range: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(scale.base, base, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(scale.range, range, accuracy: 0.0001, file: file, line: line)
    }

    func assertSpin(_ spin: Plume.Cell.Spin, base: CGFloat, range: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(spin.base, base, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(spin.range, range, accuracy: 0.0001, file: file, line: line)
    }

    func assertVelocity(_ velocity: Plume.Cell.Velocity, base: CGFloat, range: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(velocity.base, base, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(velocity.range, range, accuracy: 0.0001, file: file, line: line)
    }

    func assertCell(
        _ cell: Plume.Cell,
        expectedPixelWidth: Int?,
        expectedPixelHeight: Int?,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(cell.contents.image?.width, expectedPixelWidth, file: file, line: line)
        XCTAssertEqual(cell.contents.image?.height, expectedPixelHeight, file: file, line: line)
        XCTAssertEqual(cell.lifetime.base, Plume.Cell.Lifetime.ambient.base, file: file, line: line)
        XCTAssertEqual(cell.lifetime.range, Plume.Cell.Lifetime.ambient.range, file: file, line: line)
        XCTAssertEqual(cell.spin.base, Plume.Cell.Spin.chaotic.base, file: file, line: line)
        XCTAssertEqual(cell.spin.range, Plume.Cell.Spin.chaotic.range, file: file, line: line)
        XCTAssertEqual(cell.scale.base, Plume.Cell.Scale.huge.base, file: file, line: line)
        XCTAssertEqual(cell.scale.range, Plume.Cell.Scale.huge.range, file: file, line: line)
        XCTAssertEqual(cell.acceleration.x, Plume.Cell.Acceleration.downLeft.x, file: file, line: line)
        XCTAssertEqual(cell.acceleration.y, Plume.Cell.Acceleration.downLeft.y, file: file, line: line)
        XCTAssertEqual(cell.velocity.base, Plume.Cell.Velocity.explosive.base, file: file, line: line)
        XCTAssertEqual(cell.velocity.range, Plume.Cell.Velocity.explosive.range, file: file, line: line)
        XCTAssertEqual(cell.angle.base, Plume.Cell.Angle.bottomHemisphere.base, file: file, line: line)
        XCTAssertEqual(cell.angle.range, Plume.Cell.Angle.bottomHemisphere.range, file: file, line: line)
    }

    func assertEmitterLayer(
        for preset: EmitterPreset,
        expectedSize: CGSize,
        expectedMode: Plume.Emitter.Mode,
        expectedLayerMode: CAEmitterLayerEmitterMode,
        expectedLayerShape: CAEmitterLayerEmitterShape,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let plume = makePlume(shape: preset)
        let view = PlumeUIView(plume: plume)
        view.frame = CGRect(x: 0, y: 0, width: 120, height: 80)

        view.emit()

        guard let emitter = view.layer.sublayers?.last as? CAEmitterLayer else {
            return XCTFail("Expected CAEmitterLayer", file: file, line: line)
        }

        XCTAssertEqual(emitter.birthRate, Float(plume.emitter.birthRate), file: file, line: line)
        XCTAssertEqual(emitter.emitterPosition, CGPoint(x: 60, y: 40), file: file, line: line)
        XCTAssertEqual(emitter.emitterMode, expectedLayerMode, file: file, line: line)
        XCTAssertEqual(emitter.emitterShape, expectedLayerShape, file: file, line: line)
        XCTAssertEqual(emitter.emitterSize.width, expectedSize.width, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(emitter.emitterSize.height, expectedSize.height, accuracy: 0.0001, file: file, line: line)
        XCTAssertEqual(plume.emitter.mode, expectedMode, file: file, line: line)

        let cells = emitter.emitterCells
        XCTAssertEqual(cells?.count, 1, file: file, line: line)
        XCTAssertEqual(cells?.first?.birthRate, 1, file: file, line: line)
    }

    func makePlume(shape: EmitterPreset) -> Plume {
        let emitter: Plume.Emitter
        switch shape {
        case .point:
            emitter = .point(birthRate: 21)
        case .line:
            emitter = .line(birthRate: 21)
        case .circle:
            emitter = .circle(birthRate: 21)
        case .rectangle:
            emitter = .rectangle(birthRate: 21)
        }

        return Plume(emitter: emitter, cells: makeCells(from: [makeUIImage()]))
    }

    func makeCells(from images: [UIImage]) -> [Plume.Cell] {
        [Plume.Cell].make(
            from: images,
            lifetime: .ambient,
            spin: .chaotic,
            scale: .huge,
            acceleration: .downLeft,
            velocity: .explosive,
            angle: .bottomHemisphere
        )
    }

    func makeUIImage(color: UIColor = .systemPink, size: CGSize = CGSize(width: 4, height: 4)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
