# Plume

<p align="center">
  <img src="https://img.shields.io/badge/platform-iOS-blue?style=flat-square" />
  <img src="https://img.shields.io/badge/license-MIT-green?style=flat-square" />
  <img src="https://img.shields.io/badge/Swift_Package-Compatible-orange?style=flat-square&logo=swift" />
  <a href="https://github.com/samlupton/Plume/actions">
    <img src="https://github.com/samlupton/Plume/actions/workflows/swift.yml/badge.svg" />
  </a>
</p>

<p align="center">
  <img src="demo-videos/background.gif" alt="Background plume demo" width="32%" />
  <img src="demo-videos/cannons.gif" alt="Cannons plume demo" width="32%" />
  <img src="demo-videos/shower.gif" alt="Shower plume demo" width="32%" />
</p>

`Plume` is a Swift package for building particle effects with `CAEmitterLayer` and using them from SwiftUI or UIKit. The public API is centered around a single `Plume` value that combines an emitter and one or more particle cells.

## Requirements

- iOS 12+
- Swift Package Manager
- UIKit or SwiftUI

## Installation

Add `Plume` as a Swift package dependency, then import it where needed:

```swift
import Plume
```

## Overview

The package has three main pieces:

- `Plume`, the top-level effect model
- `PlumeView` and `PlumeUIView`, the SwiftUI and UIKit renderers
- a set of convenience extensions for quickly building emitters, cells, and preset motion values

## Type Tree

The public API is organized around `Plume` as the root type. Its purpose is to show the main model pieces you compose when building an effect.

```text
Plume
|_ Emitter
|_ Cell
|  |_ Contents
|  |_ Lifetime
|  |_ Spin
|  |_ Scale
|  |_ Acceleration
|  |_ Velocity
|  |_ Angle
```

## Building a Plume

At the center of the package is `Plume`, which combines:

- one `Plume.Emitter`
- one or more `Plume.Cell` values

To create an emitter, use the built-in factory methods:

- `Plume.Emitter.point(birthRate:)`
- `Plume.Emitter.line(birthRate:)`
- `Plume.Emitter.circle(birthRate:)`
- `Plume.Emitter.rectangle(birthRate:)`

Here is a small example that builds a plume from SF Symbols-backed images:

```swift
import UIKit
import Plume

let images = [
    UIImage(systemName: "star.fill")!,
    UIImage(systemName: "circle.fill")!,
    UIImage(systemName: "seal.fill")!
]

let plume = Plume(
    emitter: .circle(birthRate: 24),
    cells: .make(
        from: images,
        lifetime: .normal,
        spin: .normal,
        scale: .small,
        acceleration: .gravity,
        velocity: .standard,
        angle: .radial
    )
)
```

## SwiftUI Usage

Use `PlumeView` when the effect belongs inside a SwiftUI hierarchy. The view is trigger-based: when the `trigger` value changes, the underlying `PlumeUIView` emits again.

```swift
import SwiftUI
import UIKit
import Plume

struct CelebrationView: View {
    @State private var trigger = 0

    private let plume = Plume(
        emitter: .line(birthRate: 18),
        cells: .make(
            from: [
                UIImage(systemName: "star.fill")!,
                UIImage(systemName: "triangle.fill")!
            ],
            lifetime: .normal,
            spin: .lively,
            scale: .small,
            acceleration: .gravityLight,
            velocity: .lively,
            angle: .topHemisphere
        )
    )

    var body: some View {
        ZStack {
            Button("Celebrate") {
                trigger += 1
            }

            PlumeView(plume: plume, trigger: trigger)
                .allowsHitTesting(false)
        }
    }
}
```

Use this approach when the plume effect should be attached to a specific screen or view tree.

## UIKit Usage

Use `PlumeUIView` when you want direct UIKit control. Create the view, size it to your container, add it to the hierarchy, and call `emit()`.

```swift
import UIKit
import Plume

final class CelebrationViewController: UIViewController {
    private let plume = Plume(
        emitter: .rectangle(birthRate: 20),
        cells: .make(
            from: [
                UIImage(systemName: "sparkle")!,
                UIImage(systemName: "circle.fill")!
            ],
            lifetime: .normal,
            spin: .normal,
            scale: .small,
            acceleration: .gravity,
            velocity: .standard,
            angle: .bottomHemisphere
        )
    )

    private lazy var plumeView = PlumeUIView(plume: plume)

    override func viewDidLoad() {
        super.viewDidLoad()

        plumeView.frame = view.bounds
        plumeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(plumeView)
    }

    func celebrate() {
        plumeView.emit()
    }
}
```

## Convenience Helpers

The package includes a few helpers to make common effects easier to express:

- `Array.make(from:)` for turning arrays of `UIImage`, `CGImage`, or `ImageResource` values into `[Plume.Cell]`
- `Array.make(with:)` for turning a decoded `PlumeDataTransferObject` into `[Plume.Cell]`
- `Plume.Emitter` presets such as `.point(birthRate:)`, `.line(birthRate:)`, `.circle(birthRate:)`, and `.rectangle(birthRate:)`
- `Plume.Cell.Acceleration` presets such as `.zero`, `.gravity`, `.gravityLight`, `.lift`, `.upLeft`, and `.downRight`
- `Plume.Cell.Angle` presets such as `.up`, `.down`, `.topHemisphere`, and `.radial`
- `Plume.Cell.Lifetime` presets such as `.instant`, `.normal`, `.long`, and `.continuous`
- `Plume.Cell.Scale` presets such as `.tiny`, `.small`, `.normal`, `.large`, and `.massive`
- `Plume.Cell.Spin` presets such as `.none`, `.gentle`, `.normal`, `.lively`, and `.chaotic`
- `Plume.Cell.Velocity` presets such as `.zero`, `.gentle`, `.standard`, `.lively`, and `.explosive`

## Serialization

`Plume` includes a lightweight DTO-based decoding layer for configuration-driven effects.

The current transport types are:

- `Plume.DataTransferObject`
- `Plume.Cell.DataTransferObject`

This is useful when your app wants to keep effect tuning outside of Swift source, for example in bundled JSON files or remote configuration.

Example JSON:

```json
{
  "emitter": {
    "shape": "circle",
    "mode": "surface",
    "birthRate": 24
  },
  "cell": {
    "contents": [
      { "url": "https://example.com/confetti/star.png" },
      { "url": "https://example.com/confetti/circle.png" }
    ],
    "lifetime": { "base": 2.5, "range": 0.8 },
    "spin": { "base": 1.5, "range": 0.6 },
    "scale": { "base": 1.0, "range": 0.2 },
    "acceleration": { "x": 0, "y": 300 },
    "velocity": { "base": 100, "range": 25 },
    "angle": { "base": 0, "range": 1.57 }
  }
}
```

Decoded values map as follows:

- `Plume.DataTransferObject` decodes one emitter and one template cell
- `Plume.Cell.DataTransferObject` decodes an array of remote image URLs plus shared motion configuration
- each `cell.contents` entry decodes one remote image URL
- `Plume.Emitter.Shape` and `Plume.Emitter.Mode` decode from string values such as `"circle"` and `"surface"`
- scalar types such as `Acceleration`, `Angle`, `Lifetime`, `Scale`, `Spin`, and `Velocity` also decode directly

## Remote Image Loading

`Array.make(with:)` adds an async throwing factory for building particle cells from a decoded `Plume.DataTransferObject`.

Use it when a serialized plume payload provides remote particle artwork and a shared template cell:

```swift
import Foundation
import Plume

let data = Data(json.utf8)
let dto = try JSONDecoder().decode(PlumeDataTransferObject.self, from: data)
let cells = try await [Plume.Cell].make(with: dto)
```

Behavior notes:

- `make(with:)` downloads every remote image referenced by `cell.contents`.
- Each successfully decoded image becomes one `Plume.Cell` using the shared template cell configuration.
- The factory downloads all images concurrently.
- The method throws if any download task fails.
- The API is marked `@available(iOS 17.0, *)`.

Use the existing `UIImage`, `CGImage`, or `ImageResource` overloads when your particle assets are already local.

## Public Typealiases

If you prefer flatter names, the package exposes typealiases for the most common nested types:

```swift
typealias PlumeCell = Plume.Cell
typealias PlumeEmitter = Plume.Emitter
typealias CellAcceleration = Plume.Cell.Acceleration
typealias CellContents = Plume.Cell.Contents
typealias CellAngle = Plume.Cell.Angle
typealias CellLifetime = Plume.Cell.Lifetime
typealias CellScale = Plume.Cell.Scale
typealias CellSpin = Plume.Cell.Spin
typealias CellVelocity = Plume.Cell.Velocity
typealias CellDataTransferObject = Plume.Cell.DataTransferObject
typealias PlumeDataTransferObject = Plume.DataTransferObject
```

## Choosing an API

- Use `PlumeView` for SwiftUI screens.
- Use `PlumeUIView` for UIKit screens and custom view hierarchies.
- Use direct `Plume` construction when you want precise control over emitter behavior.

## Notes

- `PlumeView` is trigger-driven and emits when the `trigger` input changes.
- `PlumeUIView` is non-interactive by default and is intended to sit on top of other content.
- `Plume.Emitter.Mode` and `Plume.Emitter.Shape` are implementation details; the public entry point is the emitter factory API.
- Most motion/value types are currently intended to be used through their preset constants rather than direct initialization.
- Remote URL-backed cell creation is asynchronous and currently available on iOS 17 and later.
