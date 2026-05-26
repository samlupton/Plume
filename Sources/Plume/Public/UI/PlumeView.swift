//
//  PlumeView.swift
//  Plume
//
//  Created by Samuel Lupton on 10/9/25.
//

import SwiftUI
import UIKit

/// A SwiftUI view that renders and emits plume particles.
///
/// Use this view when a plume effect should be embedded in a SwiftUI hierarchy
/// and triggered by changes in view state.
public struct PlumeView: UIViewRepresentable {
    public typealias UIViewType = UIView

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

    /// Creates the underlying UIKit view.
    public func makeUIView(context: Context) -> UIView {
        PlumeUIView(plume: plume)
    }

    /// Updates the UIKit view and emits when the trigger changes.
    public func updateUIView(_ uiView: UIView, context: Context) {
        guard let uiView = uiView as? PlumeUIView else {
            return
        }

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
