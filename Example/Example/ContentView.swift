//
//  ContentView.swift
//  Example
//
//  Created by Samuel Lupton on 11/22/26.
//

import SwiftUI
import Plume

struct ContentView: View {
    @State var trigger: Int = 0
    @State var trigger1: Int = 0
    var body: some View {
        HStack{
            VStack(alignment: .trailing) {
                PlumeView(
                    plume: .init(
                        emitter: .point(birthRate: 1),
                        cells: .make(
                            from: Self.images,
                            lifetime: .ambient,
                            spin: .chaotic,
                            scale: .tiny,
                            acceleration: .gravityLight,
                            velocity: .lively,
                            angle: .upRight
                        ),
                    ), trigger: trigger
                )
                .frame(maxWidth: 10, alignment: .trailing)
            }
            VStack(alignment: .trailing) {
                PlumeView(
                    plume: .init(
                        emitter: .point(birthRate: 1),
                        cells: .make(
                            from: Self.images,
                            lifetime: .ambient,
                            spin: .chaotic,
                            scale: .tiny,
                            acceleration: .gravityLight,
                            velocity: .lively,
                            angle: .upLeft
                        ),
                    ), trigger: trigger1
                )
                .frame(maxWidth: 10, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        Button("Emit") {
            Task {
                trigger += 1
                try? await Task.sleep(nanoseconds: 500_000_000)
                trigger1 += 1
            }
        }
    }
}

extension ContentView {
    static let images: [ImageResource] = [
        ImageResource.ellipse109,
        ImageResource.ellipse110,
        ImageResource.ellipse111,
        ImageResource.ellipse112,
        ImageResource.ellipse113,
        ImageResource.polygon6,
        ImageResource.rectangle1238,
        ImageResource.rectangle1239,
        ImageResource.star1,
        ImageResource.subtract,
        ImageResource.vector
    ]
}

#Preview {
    ContentView()
}
