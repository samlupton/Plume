//
//  PlumeView.swift
//  Plume
//
//  Created by Samuel Lupton on 10/9/25.
//

import SwiftUI

/// A SwiftUI wrapper around `PlumeUIView`.
///
/// Use this view when a plume effect should be embedded in a SwiftUI hierarchy
/// and triggered by changes in view state.
public struct PlumeView: UIViewRepresentable {
    /// The plume rendered by the underlying UIKit view.
    var plume: Plume

    /// A trigger token used to request a new emission.
    let trigger: Int
    
    /// Creates a SwiftUI plume view from a plume definition and trigger value.
    ///
    /// - Parameters:
    ///   - plume: The plume rendered by the underlying UIKit view.
    ///   - trigger: A value that causes emission whenever it changes.
    public init(plume: Plume, trigger: Int) {
        self.plume = plume
        self.trigger = trigger
    }

    /// Creates the underlying UIKit plume view.
    public func makeUIView(context: Context) -> PlumeUIView {
        PlumeUIView(plume: plume)
    }

    /// Updates the UIKit plume view and emits when the trigger changes.
    public func updateUIView(_ uiView: PlumeUIView, context: Context) {
        if context.coordinator.lastTrigger != trigger {
            context.coordinator.lastTrigger = trigger
            uiView.emit()
        }
    }

    /// Creates the coordinator used to detect trigger changes.
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    /// Tracks the most recent trigger value to prevent duplicate emissions.
    public final class Coordinator {
        var lastTrigger: Int = 0
    }
}
