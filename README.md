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

- `Array.make(from:)` for turning arrays of `UIImage`, `CGImage`, `ImageResource`, or remote `URL` values into `[Plume.Cell]`
- `Plume.Emitter` presets such as `.point(birthRate:)`, `.line(birthRate:)`, `.circle(birthRate:)`, and `.rectangle(birthRate:)`
- `Plume.Cell.Acceleration` presets such as `.zero`, `.gravity`, `.gravityLight`, `.lift`, `.upLeft`, and `.downRight`
- `Plume.Cell.Angle` presets such as `.up`, `.down`, `.topHemisphere`, and `.radial`
- `Plume.Cell.Lifetime` presets such as `.instant`, `.normal`, `.long`, and `.continuous`
- `Plume.Cell.Scale` presets such as `.tiny`, `.small`, `.normal`, `.large`, and `.massive`
- `Plume.Cell.Spin` presets such as `.none`, `.gentle`, `.normal`, `.lively`, and `.chaotic`
- `Plume.Cell.Velocity` presets such as `.zero`, `.gentle`, `.standard`, `.lively`, and `.explosive`

## Decoding Cell Configuration

`Plume.Cell` and its scalar configuration types now conform to `Decodable`, which makes it practical to load particle behavior from JSON or other serialized payloads.

The following types can be decoded directly:

- `Plume.Cell`
- `Plume.Cell.Acceleration`
- `Plume.Cell.Angle`
- `Plume.Cell.Lifetime`
- `Plume.Cell.Scale`
- `Plume.Cell.Spin`
- `Plume.Cell.Velocity`

This is useful when your app wants to keep effect tuning outside of Swift source, for example in bundled JSON files, remote configuration, or A/B test payloads.

Example JSON:

```json
{
  "contents": {},
  "lifetime": { "base": 4, "range": 1 },
  "spin": { "base": 1.5, "range": 0.5 },
  "scale": { "base": 0.2, "range": 0.08 },
  "acceleration": { "x": 0, "y": 120 },
  "velocity": { "base": 180, "range": 60 },
  "angle": { "base": -1.57, "range": 0.8 }
}
```

Decoded scalar values map closely to Core Animation concepts:

- `Acceleration` decodes `x` and `y`
- `Angle`, `Lifetime`, `Scale`, `Spin`, and `Velocity` decode `base` and `range`
- `Cell` combines those decoded values into a complete particle definition

`contents` is part of the decoded `Plume.Cell` shape so the payload can match the full model, but image loading should still be treated as a separate concern. In practice, decode the motion values and supply image-backed cells through one of the image factory APIs described below when you are preparing a renderable plume.

## Remote Image Loading

`Array.make(from:urls:lifetime:spin:scale:acceleration:velocity:angle:)` adds an async throwing factory for building particle cells from remote images.

Use it when the particle artwork is not known at compile time:

```swift
import Plume

let imageURLs = [
    URL(string: "https://example.com/confetti/star.png")!,
    URL(string: "https://example.com/confetti/circle.png")!
]

let cells = try await [Plume.Cell].make(
    from: imageURLs,
    lifetime: .normal,
    spin: .normal,
    scale: .small,
    acceleration: .gravity,
    velocity: .standard,
    angle: .radial
)
```

Behavior notes:

- The factory downloads all images concurrently.
- Each successfully decoded image becomes one `Plume.Cell`.
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
