//
//  SerializationTests.swift
//  Plume
//
//  Created by Samuel Lupton on 5/7/26.
//

import XCTest
@testable import Plume

final class SerializationTests: XCTestCase {
    func testContentsDataTransferObjectDecodesURL() throws {
        let dto: Plume.Cell.Contents.DataTransferObject = try decode("""
        {
          "url": "https://example.com/confetti.png"
        }
        """)

        XCTAssertEqual(dto.url, URL(string: "https://example.com/confetti.png"))
    }

    func testCellDataTransferObjectDecodesNestedConfiguration() throws {
        let dto: Plume.Cell.DataTransferObject = try decode("""
        {
          "contents": [
            {
              "url": "https://example.com/star.png"
            },
            {
              "url": "https://example.com/circle.png"
            }
          ],
          "lifetime": {
            "base": 2.5,
            "range": 0.8
          },
          "spin": {
            "base": 1.5,
            "range": 0.6
          },
          "scale": {
            "base": 1.0,
            "range": 0.2
          },
          "acceleration": {
            "x": 0,
            "y": 300
          },
          "velocity": {
            "base": 100,
            "range": 25
          },
          "angle": {
            "base": 0,
            "range": 3.141592653589793
          }
        }
        """)

        XCTAssertEqual(dto.contents.count, 2)
        XCTAssertEqual(dto.contents[0].url, URL(string: "https://example.com/star.png"))
        XCTAssertEqual(dto.contents[1].url, URL(string: "https://example.com/circle.png"))
        XCTAssertEqual(dto.lifetime.base, 2.5, accuracy: 0.0001)
        XCTAssertEqual(dto.lifetime.range, 0.8, accuracy: 0.0001)
        XCTAssertEqual(dto.spin.base, 1.5, accuracy: 0.0001)
        XCTAssertEqual(dto.spin.range, 0.6, accuracy: 0.0001)
        XCTAssertEqual(dto.scale.base, 1.0, accuracy: 0.0001)
        XCTAssertEqual(dto.scale.range, 0.2, accuracy: 0.0001)
        XCTAssertEqual(dto.acceleration.x, 0, accuracy: 0.0001)
        XCTAssertEqual(dto.acceleration.y, 300, accuracy: 0.0001)
        XCTAssertEqual(dto.velocity.base, 100, accuracy: 0.0001)
        XCTAssertEqual(dto.velocity.range, 25, accuracy: 0.0001)
        XCTAssertEqual(dto.angle.base, 0, accuracy: 0.0001)
        XCTAssertEqual(dto.angle.range, .pi, accuracy: 0.0001)
    }

    func testPlumeDataTransferObjectDecodesEmitterAndCell() throws {
        let dto: Plume.DataTransferObject = try decode("""
        {
          "emitter": {
            "shape": "circle",
            "mode": "surface",
            "birthRate": 24
          },
          "cell": {
            "contents": [
              {
                "url": "https://example.com/circle.png"
              },
              {
                "url": "https://example.com/star.png"
              }
            ],
            "lifetime": {
              "base": 2.5,
              "range": 0.8
            },
            "spin": {
              "base": 1.5,
              "range": 0.6
            },
            "scale": {
              "base": 1.0,
              "range": 0.2
            },
            "acceleration": {
              "x": 0,
              "y": 300
            },
            "velocity": {
              "base": 100,
              "range": 25
            },
            "angle": {
              "base": 0,
              "range": 1.5707963267948966
            }
          }
        }
        """)

        XCTAssertEqual(dto.emitter.shape, .circle)
        XCTAssertEqual(dto.emitter.mode, .surface)
        XCTAssertEqual(dto.emitter.birthRate, 24, accuracy: 0.0001)
        XCTAssertEqual(dto.cell.contents.count, 2)
        XCTAssertEqual(dto.cell.contents[0].url, URL(string: "https://example.com/circle.png"))
        XCTAssertEqual(dto.cell.contents[1].url, URL(string: "https://example.com/star.png"))
        XCTAssertEqual(dto.cell.angle.range, .pi / 2, accuracy: 0.0001)
    }

    func testEmitterAndScalarModelsDecodeFromJSON() throws {
        let emitter: Plume.Emitter = try decode("""
        {
          "shape": "line",
          "mode": "outline",
          "birthRate": 18
        }
        """)

        let acceleration: Plume.Cell.Acceleration = try decode("""
        {
          "x": -50,
          "y": 100
        }
        """)

        let velocity: Plume.Cell.Velocity = try decode("""
        {
          "base": 200,
          "range": 60
        }
        """)

        XCTAssertEqual(emitter.shape, .line)
        XCTAssertEqual(emitter.mode, .outline)
        XCTAssertEqual(emitter.birthRate, 18, accuracy: 0.0001)
        XCTAssertEqual(acceleration.x, -50, accuracy: 0.0001)
        XCTAssertEqual(acceleration.y, 100, accuracy: 0.0001)
        XCTAssertEqual(velocity.base, 200, accuracy: 0.0001)
        XCTAssertEqual(velocity.range, 60, accuracy: 0.0001)
    }
}

private extension SerializationTests {
    func decode<T: Decodable>(_ json: String, as type: T.Type = T.self) throws -> T {
        try JSONDecoder().decode(type, from: Data(json.utf8))
    }
}

